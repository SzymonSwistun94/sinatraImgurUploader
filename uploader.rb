require 'celluloid'

class Uploader
  include Celluloid

  attr_accessor :uuid
  attr_accessor :url

  def initialize(file, uuid)
    @uuid = uuid
    @file = file
    # @cache = cache
  end

  def upload
    require 'imgur'

    client = Imgur::Client.new '459a758614e4c94'
    # File.open(uuid, 'wb')

    image = Imgur::LocalImage.new @file
    up = client.upload image
    link = up.link.to_s
    @url = 'https' + link[link.index('://'), link.length - 1]
    # @cache.add_url_to_cache(@uuid, url)
  end

end