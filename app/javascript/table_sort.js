// Click-to-sort for every admin table.
//
// Each sortable <th> gets a pill button (⇅ → ▲/▼). Clicking cycles
// ascending → descending → original order. Sorting is client-side, so on a
// paginated list it orders the rows of the current page only; pages that need
// a whole-dataset sort (bookings, products) render server-side
// sort links via ApplicationHelper#sort_header instead, and this script
// leaves those tables alone.
//
// Opt-outs: <table data-no-sort> skips a whole table, <th data-no-sort> skips
// a column. <td data-sort-value="..."> overrides the value a cell sorts by.

const STYLE_ID = 'table-sort-styles';
const CSS = `
  .sort-btn {
    display: inline-flex; align-items: center; gap: .4rem;
    background: none; border: 0; padding: 0; margin: 0;
    font: inherit; color: inherit; text-decoration: none; cursor: pointer;
    white-space: nowrap; user-select: none;
  }
  .sort-btn:hover, .sort-btn:focus-visible { color: var(--bs-primary, #0d6efd); outline: none; }
  .sort-btn .sort-icon {
    display: inline-flex; align-items: center; justify-content: center;
    width: 1.35rem; height: 1.35rem; border-radius: 50%;
    font-size: .7rem; line-height: 1;
    background: rgba(13, 110, 253, .08); color: #6c757d;
    transition: background .15s ease, color .15s ease, transform .15s ease;
  }
  .sort-btn:hover .sort-icon { background: rgba(13, 110, 253, .18); color: var(--bs-primary, #0d6efd); transform: scale(1.08); }
  .sort-btn.active { color: var(--bs-primary, #0d6efd); }
  .sort-btn.active .sort-icon {
    background: var(--bs-primary, #0d6efd); color: #fff;
    box-shadow: 0 2px 6px rgba(13, 110, 253, .35);
  }
`;

const SKIP_HEADER = /^(actions?|action|options|manage|#|s\.?\s*no\.?|sl\.?\s*no\.?|select)$/i;
const MONTHS = { jan: 0, feb: 1, mar: 2, apr: 3, may: 4, jun: 5, jul: 6, aug: 7, sep: 8, oct: 9, nov: 10, dec: 11 };

function injectStyles() {
  if (document.getElementById(STYLE_ID)) return;
  const style = document.createElement('style');
  style.id = STYLE_ID;
  style.textContent = CSS;
  document.head.appendChild(style);
}

function cellValue(cell) {
  if (!cell) return '';
  if (cell.dataset.sortValue !== undefined) return cell.dataset.sortValue.trim();
  const field = cell.querySelector('input:not([type=hidden]):not([type=checkbox]), select, textarea');
  if (field) return (field.tagName === 'SELECT' ? field.options[field.selectedIndex]?.text : field.value || '').trim();
  return cell.textContent.replace(/\s+/g, ' ').trim();
}

function parseNumber(text) {
  const cleaned = text.replace(/₹|rs\.?|inr|,/gi, '').trim();
  const m = cleaned.match(/^[-+]?\d+(\.\d+)?/);
  return m ? parseFloat(m[0]) : null;
}

function parseDate(text) {
  let m = text.match(/^(\d{1,2})[\/\-.](\d{1,2})[\/\-.](\d{4})/); // dd/mm/yyyy (Indian format)
  if (m) return new Date(+m[3], +m[2] - 1, +m[1]).getTime();
  m = text.match(/^(\d{4})-(\d{2})-(\d{2})/);
  if (m) return new Date(+m[1], +m[2] - 1, +m[3]).getTime();
  m = text.match(/^(\d{1,2})\s+([A-Za-z]{3})[a-z]*,?\s+(\d{4})(?:[,\s]+(\d{1,2}):(\d{2})\s*([AP]M)?)?/i); // 12 Oct 2026[, 03:15 PM]
  if (m && MONTHS[m[2].toLowerCase()] !== undefined) {
    let h = +(m[4] || 0);
    if (m[6]) h = (h % 12) + (m[6].toUpperCase() === 'PM' ? 12 : 0);
    return new Date(+m[3], MONTHS[m[2].toLowerCase()], +m[1], h, +(m[5] || 0)).getTime();
  }
  m = text.match(/^([A-Za-z]{3})[a-z]*\s+(\d{1,2}),?\s+(\d{4})/); // Oct 12, 2026
  if (m && MONTHS[m[1].toLowerCase()] !== undefined) return new Date(+m[3], MONTHS[m[1].toLowerCase()], +m[2]).getTime();
  return null;
}

// Pick the column's comparison type from all its non-empty values: dates win
// over numbers (a "12/10/2026" also starts with a number), text is the fallback.
function columnType(values) {
  const present = values.filter((v) => v !== '' && v !== '-' && v !== '—' && !/^n\/?a$/i.test(v));
  if (!present.length) return 'text';
  if (present.every((v) => parseDate(v) !== null)) return 'date';
  if (present.every((v) => parseNumber(v) !== null)) return 'number';
  return 'text';
}

function sortKey(value, type) {
  if (value === '' || value === '-' || value === '—' || /^n\/?a$/i.test(value)) return null;
  if (type === 'date') return parseDate(value);
  if (type === 'number') return parseNumber(value);
  return value.toLowerCase();
}

// Real sortable data rows only: skip tables with grouped/expandable detail
// rows (colspan cells) or multi-row headers — reordering those would split
// rows from their detail rows.
function sortableRows(table) {
  const body = table.tBodies[0];
  if (!body || table.tBodies.length > 1) return null;
  const rows = Array.from(body.rows);
  if (rows.length < 2) return null;
  if (rows.some((r) => Array.from(r.cells).some((c) => c.colSpan > 1))) return null;
  return rows;
}

function enhanceTable(table) {
  if (table.dataset.sortReady || table.hasAttribute('data-no-sort')) return;
  if (!table.tHead || table.tHead.rows.length !== 1) return;
  if (table.tHead.querySelector('.sort-btn')) return; // server-side sorted (sort_header helper)
  const rows = sortableRows(table);
  if (!rows) return;
  table.dataset.sortReady = '1';
  rows.forEach((r, i) => { r.dataset.sortOrigIndex = i; });

  let colIndex = 0;
  Array.from(table.tHead.rows[0].cells).forEach((th) => {
    const index = colIndex;
    colIndex += th.colSpan;
    const label = th.textContent.replace(/\s+/g, ' ').trim();
    if (!label || th.colSpan > 1 || th.hasAttribute('data-no-sort') || SKIP_HEADER.test(label)) return;
    if (th.querySelector('input, select, button, a')) return;

    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'sort-btn';
    btn.title = `Sort by ${label}`;
    const text = document.createElement('span');
    while (th.firstChild) text.appendChild(th.firstChild);
    const icon = document.createElement('span');
    icon.className = 'sort-icon';
    icon.innerHTML = '<i class="bi bi-chevron-expand"></i>';
    btn.append(text, icon);
    th.appendChild(btn);
    th.setAttribute('aria-sort', 'none');
    btn.addEventListener('click', () => sortBy(table, th, index));
  });
}

function sortBy(table, th, index) {
  const body = table.tBodies[0];
  const rows = Array.from(body.rows);
  // Rows appended by JS after the table was enhanced go after the originals.
  let maxOrig = Math.max(-1, ...rows.map((r) => +(r.dataset.sortOrigIndex ?? -1)));
  rows.forEach((r) => { if (r.dataset.sortOrigIndex === undefined) r.dataset.sortOrigIndex = ++maxOrig; });
  const state = th.getAttribute('aria-sort');
  const next = state === 'none' ? 'ascending' : state === 'ascending' ? 'descending' : 'none';

  table.tHead.querySelectorAll('th[aria-sort]').forEach((other) => {
    other.setAttribute('aria-sort', 'none');
    other.querySelector('.sort-btn')?.classList.remove('active');
    const i = other.querySelector('.sort-icon i');
    if (i) i.className = 'bi bi-chevron-expand';
  });

  let sorted;
  if (next === 'none') {
    sorted = rows.sort((a, b) => a.dataset.sortOrigIndex - b.dataset.sortOrigIndex);
  } else {
    const values = rows.map((r) => cellValue(r.cells[index]));
    const type = columnType(values);
    const dir = next === 'ascending' ? 1 : -1;
    const keyed = rows.map((r, i) => ({ r, k: sortKey(values[i], type), o: +r.dataset.sortOrigIndex }));
    keyed.sort((a, b) => {
      if (a.k === null && b.k === null) return a.o - b.o;
      if (a.k === null) return 1; // blanks always last
      if (b.k === null) return -1;
      const c = type === 'text' ? a.k.localeCompare(b.k, undefined, { numeric: true }) : a.k - b.k;
      return c * dir || a.o - b.o;
    });
    sorted = keyed.map((x) => x.r);
    th.setAttribute('aria-sort', next);
    th.querySelector('.sort-btn').classList.add('active');
    th.querySelector('.sort-icon i').className = next === 'ascending' ? 'bi bi-caret-up-fill' : 'bi bi-caret-down-fill';
  }
  sorted.forEach((r) => body.appendChild(r));
}

function initTableSort() {
  injectStyles();
  document.querySelectorAll('main table, .main-content table, #main-content table, .content-wrapper table, table.table')
    .forEach(enhanceTable);
}

document.addEventListener('DOMContentLoaded', initTableSort);
document.addEventListener('turbo:load', initTableSort);
document.addEventListener('turbo:frame-load', initTableSort);
if (document.readyState !== 'loading') initTableSort();
