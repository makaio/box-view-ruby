# = Examples

# Require libraries and set API token
require 'pathname'
require_relative 'lib/box-view'
BoxView.api_token = ENV['BOX_VIEW_TOKEN']
Crocodoc = BoxView

# == Example #1
#
# Upload a file to Crocodoc. We're uploading Form W4 from the IRS by URL.
puts 'Example #1 - Upload Form W4 from the IRS by URL.'
form_w4_url = 'http://www.irs.gov/pub/irs-pdf/fw4.pdf'
print '  Uploading... '
uuid = nil

begin
  uuid = Crocodoc::Document.upload(form_w4_url)
  puts 'success :)'
  puts '  UUID is ' + uuid
rescue CrocodocError => e
  puts 'failed :('
  puts '  Error Code: ' + e.code
  puts '  Error Message: ' + e.message
end

# == Example #2
#
# Check the status of the file from Example #1.
puts ''
puts 'Example #2 - Check the status of the file we just uploaded.'
print '  Checking status... '

begin
  status = Crocodoc::Document.status(uuid)

  unless status.has_key? 'error'
    puts 'success :)'
    puts '  File status is ' + status['status'] + '.'
    puts '  File ' + (status['viewable'] ? 'is' : 'is not') + ' viewable.'
  else
    puts 'failed :('
    puts '  Error Message: ' + status['error']
  end
rescue CrocodocError => e
  puts 'failed :('
  puts '  Error Code: ' + e.code
  puts '  Error Message: ' + e.message
end

# == Example #3
#
# Wait ten seconds and check the status of both files again.
puts ''
puts 'Example #3 - Wait ten seconds and check the status again.'
print '  Waiting... '
sleep(10)
puts 'done.'
print '  Checking status... '

begin
  status = Crocodoc::Document.status(uuid)

  if status
    puts 'success :)'

    unless status.has_key? 'error'
      puts '  File status is ' + status['status'] + '.'
      puts '  File ' + (status['viewable'] ? 'is' : 'is not') + ' viewable.'
    else
      puts '  File #1 failed :('
      puts '  Error Message: ' . status['error']
    end

  else
    puts 'failed :('
    puts '  Status was not returned.'
  end
rescue CrocodocError => e
  puts 'failed :('
  puts '  Error Code: ' + e.code
  puts '  Error Message: ' + e.message
end

# == Example #4
#
# Download the file we uploaded from Example #1 as a PDF
puts ''
puts 'Example #4 - Download a file as a PDF.'
print '  Downloading... '

begin
  file = Crocodoc::Download.document(uuid, true)
  filename = String(Pathname.new(File.expand_path(__FILE__)).dirname) + '/example-files/test.pdf'
  file_handle = File.open(filename, 'w')
  file_handle.write(file)
  puts 'success :)'
  puts '  File was downloaded to ' + filename + '.'
rescue CrocodocError => e
  puts 'failed :('
  puts '  Error Code: ' + e.code
  puts '  Error Message: ' + e.message
end

# == Example #5
#
# Download the file we uploaded from Example #1 as a ZIP
puts ''
puts 'Example #5 - Download a file as a ZIP.'
print '  Downloading... '

begin
  file = Crocodoc::Download.document(uuid, false)
  filename = String(Pathname.new(File.expand_path(__FILE__)).dirname) + '/example-files/test.zip'
  file_handle = File.open(filename, 'w')
  file_handle.write(file)
  puts 'success :)'
  puts '  File was downloaded to ' + filename + '.'
rescue CrocodocError => e
  puts 'failed :('
  puts '  Error Code: ' + e.code
  puts '  Error Message: ' + e.message
end

# == Example #6
#
# Create a session key for the file we uploaded from Example #3 with default
# options.
puts ''
puts 'Example #6 - Create a session key for a file with default options.'
print '  Creating... '
session_key = nil

begin
  session_key = Crocodoc::Session.create(uuid)
  view_url = Crocodoc::Session.view_url(session_key)
  puts 'success :)'
  puts '  The session key is ' + session_key + '.'
  puts '  View url is ' + view_url + '.'
rescue CrocodocError => e
  puts 'failed :('
  puts '  Error Code: ' + e.code
  puts '  Error Message: ' + e.message
end

# == Example #7
#
# Delete the file we uploaded from Example #1.
puts ''
puts 'Example #7 - Delete the first file we uploaded.'
print '  Deleting... '

begin
  deleted = Crocodoc::Document.delete(uuid)

  if deleted
    puts 'success :)'
    puts '  File was deleted.'
  else
    print 'failed :('
  end
rescue CrocodocError => e
  puts 'failed :('
  puts '  Error Code: ' + e.code
  puts '  Error Message: ' + e.message
end

