// Loaded as a classic script (not through the importmap) so it also runs on
// the standalone pages that have no importmap: logins, themes, checkout.
(function () {
  var PHONE_WIDTH = 768
  var DISMISS_KEY = "ms-install-dismissed"
  var installPrompt = null

  if ("serviceWorker" in navigator) {
    window.addEventListener("load", function () {
      navigator.serviceWorker.register("/service-worker").catch(function () {})
    })
  }

  function installDismissed() {
    try { return localStorage.getItem(DISMISS_KEY) === "1" } catch (e) { return false }
  }

  function dismissInstall() {
    try { localStorage.setItem(DISMISS_KEY, "1") } catch (e) {}
    var bar = document.getElementById("ms-install-bar")
    if (bar) bar.remove()
  }

  function isStandalone() {
    return window.matchMedia("(display-mode: standalone)").matches || window.navigator.standalone === true
  }

  function isIos() {
    return /iphone|ipad|ipod/i.test(window.navigator.userAgent)
  }

  function showInstallBar() {
    if (window.innerWidth > PHONE_WIDTH || isStandalone() || installDismissed()) return
    if (!installPrompt && !isIos()) return
    if (document.getElementById("ms-install-bar")) return

    var bar = document.createElement("div")
    bar.id = "ms-install-bar"
    bar.innerHTML = installPrompt
      ? '<span>Install the Marali Santhe app</span><button type="button" data-install>Install</button><button type="button" data-dismiss aria-label="Close">&times;</button>'
      : '<span>Tap Share, then Add to Home Screen to install the app</span><button type="button" data-dismiss aria-label="Close">&times;</button>'
    document.body.appendChild(bar)
  }

  window.addEventListener("beforeinstallprompt", function (event) {
    event.preventDefault()
    installPrompt = event
    showInstallBar()
  })

  window.addEventListener("appinstalled", dismissInstall)

  document.addEventListener("click", function (event) {
    if (event.target.closest("#ms-install-bar [data-dismiss]")) {
      dismissInstall()
    } else if (event.target.closest("#ms-install-bar [data-install]") && installPrompt) {
      installPrompt.prompt()
      installPrompt.userChoice.then(function () { installPrompt = null; dismissInstall() })
    }
  })

  // Any table not already inside a scroller gets one, so a wide table scrolls
  // inside itself instead of pushing the whole page sideways.
  function wrapTables() {
    if (window.innerWidth > PHONE_WIDTH) return

    document.querySelectorAll("table").forEach(function (table) {
      if (table.parentElement.closest("table, .table-responsive, .ms-table-scroll")) return

      var wrapper = document.createElement("div")
      wrapper.className = "ms-table-scroll"
      table.parentNode.insertBefore(wrapper, table)
      wrapper.appendChild(table)
    })
  }

  // Data tables become one card per row, each cell labelled with its column
  // heading, so the whole row is readable without swiping sideways. Tables
  // people type into stay as tables: their columns only make sense lined up.
  function stackTables() {
    if (window.innerWidth > PHONE_WIDTH) return

    document.querySelectorAll(".main-content table").forEach(function (table) {
      if (table.classList.contains("ms-stack-table") || table.closest("td")) return

      var headings = Array.prototype.map.call(table.querySelectorAll("thead th"), function (th) {
        return th.textContent.trim().replace(/\s+/g, " ")
      })
      if (headings.length < 2) return
      if (table.querySelector("tbody input:not([type='checkbox']):not([type='hidden']), tbody select, tbody textarea")) return

      table.classList.add("ms-stack-table")
      table.querySelectorAll("tbody tr").forEach(function (row) {
        Array.prototype.forEach.call(row.children, function (cell, index) {
          if (cell.colSpan > 1) cell.classList.add("ms-stack-full")
          else cell.setAttribute("data-label", headings[index] || "")
        })
      })
    })
  }

  // The customer layout wires its own drawer and uses a different sidebar id.
  function setDrawer(open) {
    var sidebar = document.getElementById("sidebar")
    if (!sidebar) return

    sidebar.classList.toggle("show", open)
    var backdrop = document.getElementById("ms-drawer-backdrop")
    if (open && !backdrop) {
      backdrop = document.createElement("div")
      backdrop.id = "ms-drawer-backdrop"
      document.body.appendChild(backdrop)
    } else if (!open && backdrop) {
      backdrop.remove()
    }
  }

  document.addEventListener("click", function (event) {
    if (event.target.closest('.mobile-toggle[data-bs-toggle="sidebar"]')) {
      var sidebar = document.getElementById("sidebar")
      if (sidebar) setDrawer(!sidebar.classList.contains("show"))
    } else if (event.target.id === "ms-drawer-backdrop" || event.target.closest("#sidebar a[href]:not([data-bs-toggle])")) {
      setDrawer(false)
    }
  })

  // Close before Turbo snapshots the page so Back doesn't restore an open drawer.
  document.addEventListener("turbo:before-cache", function () { setDrawer(false) })

  function onPageLoad() {
    wrapTables()
    stackTables()
    showInstallBar()
  }

  document.addEventListener("DOMContentLoaded", onPageLoad)
  document.addEventListener("turbo:load", onPageLoad)
  document.addEventListener("turbo:frame-load", function () { wrapTables(); stackTables() })
  if (document.readyState !== "loading") onPageLoad()
})()
