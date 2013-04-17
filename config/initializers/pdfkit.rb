# config/initializers/pdfkit.rb
bs = RbConfig::CONFIG['host']
PDFKit.configure do |config|
     bs.include?("linux") ?  config.wkhtmltopdf =  '/usr/bin/wkhtmltopdf' :  config.wkhtmltopdf =  'C:/wkhtmltopdf/wkhtmltopdf.exe'
     config.default_options = {
     :page_size => 'Legal',
     :print_media_type => true
   }
   config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
end