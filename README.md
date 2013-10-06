# box-view-ruby

## Introduction

box-view-ruby is a Ruby wrapper for the Box View API (The new version of Crocodoc API).
The Box View API lets you upload documents and then generate secure and customized viewing sessions for them.
The API is based on REST principles and generally returns JSON encoded responses,
and in Ruby are converted to hashes unless otherwise noted.

The gem is designed to keep the compatibility with the crocodoc gem so that it could work as a simple replacement for the gem. 

## Installation

It has not been published as a gem since a more proper implementation may come from the Crocodoc team.

You can add it as a gem by using the bundler's git functionality.

    gem "box-api-ruby", :git => "git://github.com/kntyskw/box-api-ruby"

You can also add the library as a submodule in your git project.

    git submodule add git@github.com:kntyskw/box-api-ruby.git

You can also get the library by cloning or downloading.

To clone:

    git clone git@github.com:kntyskw/box-api-ruby.git
    
To download:

    wget https://github.com/kntyskw/box-api-ruby/zipball/master -O box-api-ruby.zip
    unzip box-api-ruby.zip
    mv kntyskw-box-api-ruby-* box-api-ruby

Require the library into any of your Ruby files.
    
If you have the files locally:

    require_relative /path/to/box-api-ruby/crocodoc.rb

Please note that this library also requires that the 'rest-client' gem is installed, and a version of Ruby >= 1.9.
    
## Getting Started

You can see a number of examples on how to use this library in examples.rb.
These examples are interactive and you can run this file to see crocodoc-ruby in action.

To run these examples, open up examples.rb and change this line to show your API token:

    Crocodoc.api_token = 'YOUR_API_TOKEN'
    
Save the file, make sure the example-files directory is writeable, and then run examples.rb:

    ruby examples.rb
    
You should see 15 examples run with output in your terminal.
You can inspect the examples.rb code to see each API call being used.

To start using crocodoc-ruby in your code, set your API token:

    Crocodoc.api_token = 'YOUR_API_TOKEN'
    
And now you can start using the methods in Crocodoc::Document, Crocodoc::Download, and Crocodoc::Session.

Read on to find out more how to use crocodoc-ruby.
You can also find more detailed information about our API here:
https://crocodoc.com/docs/api/

## Using the Crocodoc API Library

### Errors

Errors are handled by throwing exceptions.
We throw instances of CrocodocError.

Note that any Crocodoc API call can throw an exception.
When making API calls, put them in a begin/rescue block.
You can see examples.rb to see working code for each method using begin/rescue blocks.

### Document

These methods allow you to upload, check the status of, and delete documents.

#### Upload

http://developers.box.com/view/
To upload a document, use Crocodoc::Document.upload().
Pass in a url (as a string). Note that passing a file resource object is NOT supported by Box API.
This function returns a UUID of the file.

    // with a url
    uuid = Crocodoc::Document.upload(url)
        
#### Status

http://developers.box.com/view/
To check the status of a document, use Crocodoc::Document.status().
Pass in the UUID of the file you want to check the status of.
This function returns a hash containing a "status" string" and a "viewable" boolean.
Note that passing an array instead of a string is not supported at this time

    // status contains status['status'] and status['viewable']
    status = Crocodoc::Document.status(uuid)
    
    // The foollowing is not supported right now .
    //statuses = Crocodoc::Document.status([uuid, uuid2])
    
#### Delete

http://developers.box.com/view/
To delete a document, use Crocodoc::Document.delete().
Pass in the UUID of the file you want to delete.
This function returns a boolean of whether the document was successfully deleted or not.

    deleted  = Crocodoc::Document.delete(uuid)
    
### Download

These methods allow you to download documents from Crocodoc in different ways.
You can download PDF or ZIP archive of SVG files. Note that extracting text and thumbnails is not supported.

#### Document

http://developers.box.com/view/
To download a document, use Crocodoc::Download.document().
Pass in the uuid,
an optional boolean of whether or not the file should be downloaded as a PDF.
This function returns the file contents as a string, which you probably want to save to a file.

    // with no optional arguments
    file = Crocodoc::Download.document(uuid)
    file_handle.write(file)
    
    // with all optional arguments
    file = Crocodoc::Download.document(uuid, true)
    file_handle.write(file)
    
#### Thumbnail

Currently not supported because the Box API does not provide the equivalent functionality as of writing. 

#### Text

Currently not supported because the Box API does not provide the equivalent functionality as of writing.     
### Session

The session method allows you to create a session for viewing documents in a secure manner.

#### Create

http://developers.box.com/view/
To get a session key, use Crocodoc::Session.create().
Pass in the uuid and optionally a params hash.
This function returns a session key.

    // without optional params
    session_key = Crocodoc::Session.create(uuid)
    
    
## Support

Please use github's issue tracker for API library support.
