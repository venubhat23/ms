module ImportService
  # Turns an uploaded CSV / .xlsx / .xls file into CSV text so the importers and
  # CsvValidator can keep using CSV.parse regardless of what the admin uploaded.
  module SpreadsheetReader
    require 'csv'

    EXCEL_EXTENSIONS = %w[.xlsx .xls].freeze
    ALLOWED_EXTENSIONS = (%w[.csv] + EXCEL_EXTENSIONS).freeze

    module_function

    def extension(uploaded_file)
      return nil unless uploaded_file.respond_to?(:original_filename) && uploaded_file.original_filename
      File.extname(uploaded_file.original_filename).downcase
    end

    def excel?(uploaded_file)
      EXCEL_EXTENSIONS.include?(extension(uploaded_file))
    end

    def read_csv_text(uploaded_file)
      return read_plain(uploaded_file) unless excel?(uploaded_file)

      path = uploaded_file.respond_to?(:tempfile) ? uploaded_file.tempfile.path : uploaded_file.path
      sheet = Roo::Spreadsheet.open(path, extension: extension(uploaded_file).delete('.').to_sym).sheet(0)
      return '' if sheet.last_row.nil?

      CSV.generate do |csv|
        (sheet.first_row..sheet.last_row).each do |i|
          cells = sheet.row(i).map { |c| cell_to_s(c) }
          next if cells.all?(&:blank?)
          csv << cells
        end
      end
    end

    def read_plain(uploaded_file)
      text = uploaded_file.read.to_s
      uploaded_file.rewind
      # Excel "CSV UTF-8" saves add a BOM, which would corrupt the first header.
      text.force_encoding('UTF-8').delete_prefix("﻿")
    end

    # Excel stores 1 as 1.0, HSN 19059090 as 19059090.0 and TRUE as true.
    def cell_to_s(cell)
      case cell
      when nil then ''
      when Float then cell == cell.to_i ? cell.to_i.to_s : cell.to_s
      when TrueClass, FalseClass then cell.to_s
      when DateTime, Time then cell.strftime('%Y-%m-%d %H:%M')
      when Date then cell.iso8601
      else cell.to_s.strip
      end
    end
  end
end
