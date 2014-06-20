module BoxView
  # Provides access to the BoxView Document API. The Document API is used for
  # uploading, checking status, and deleting documents.
  class Document
    # The Document API path relative to the base API path
    @@path = '/documents'

    # Set the path
    def self.path=(path)
      @@path = path
    end

    # Get the path
    def self.path
      @@path
    end

    # Delete a file on Crocodoc by UUID.
    #
    # @param [String] id The id of the file to delete
    #
    # @return [Boolean] Was the file deleted?
    # @raise [CrocodocError]
    def self.delete(id)
      BoxView._request(self.path + "/#{id}", 'delete', nil, nil, false)
    end

    # Check the status of a file on Crocodoc by UUID.
    #
    # @param String id The uuid of the file to
    #   check the status of
    #
    # @return A hash of the Document object
    # @raise [CrocodocError]
    def self.status(id)
      response = BoxView._request(self.path + "/#{id}", 'get', nil, nil)
      response['viewable'] = response['status'] == 'done' ? true : false
      response['error'] = "The document has error" if response['status'] == 'error'
      response
    end

  	# Upload a file to Crocodoc with a URL.
    #
    # @param url String The url of the file to upload
    # @param name String The name of document.
    # @param thumbnails String Comma-separated list of thumbnail dimensions of the format {width}x{height}
    #                          e.g. 128×128,256×256 – width can be between 16 and 1024, height between 16 and 768
    # @param non_svg Boolean Whether to also create the non-svg version of the document
    #
    # @return [String] The uuid of the newly-uploaded file
    # @raise [CrocodocError]
    def self.upload(url, name=nil, thumbnails=nil, non_svg=nil)
      post_params = {}

      post_params['url'] = url
      post_params['name'] = name if name
      post_params['thumbnails'] = thumbnails if thumbnails
      post_params['non_svg'] = non_svg unless non_svg.nil?

      response = BoxView::_request(self.path, 'post', nil, post_params)

      unless response.has_key? 'id'
      	return BoxView::_error('missing_uuid', self.name, __method__, response)
      end

      response['id']
    end
  end
end
