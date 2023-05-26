class DataController < ApplicationController

  def download_csv
    # Generate CSV data
    csv_data = CSV.generate do |csv|
      csv << ['Name', 'Email', 'Role']
      csv << ['John Doe', 'john@example.com', 'Admin']
      csv << ['Jane Smith', 'jane@example.com', 'User']
    end

    # Send CSV data as a file attachment
    send_data csv_data, filename: 'data.csv', type: 'text/csv'
  end

  def generate_pdf
    pdf = Prawn::Document.new
    pdf.text "Hello, World!"
    
    send_data pdf.render, filename: "document.pdf", type: "application/pdf", disposition: "inline"
  end


 #->uploading csv or import data from csv 

#   require 'csv'    

# csv_text = File.read('...')
# csv = CSV.parse(csv_text, headers: true)
# csv.each do |row|
#   Model.create!(row.to_hash)                             
# require 'csv'    

# require 'csv'

# def import_csv_data(filename)
#   CSV.foreach(filename, headers: true) do |row|
#     Model.create!(row.to_hash)
#   end
# end

# filename = 'path/to/your/file.csv'
# import_csv_data(filename)



end


end
