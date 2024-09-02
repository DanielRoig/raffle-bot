class FileContentService
  include Service

  def call
    uri = URI(image_url)
    response = Net::HTTP.get_response(uri)
    tempfile = nil

    if response.is_a?(Net::HTTPSuccess)
      tempfile = Tempfile.create(['image', '.jpg'])
      tempfile.binmode
      tempfile.write(response.body)
      tempfile.rewind
    end

    tempfile
  end

  attr_accessor :image_url
end
