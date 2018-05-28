require './uploader.rb'
require 'celluloid'

class UploadCache
  # include Celluloid

  # def self.initialize()
  @cache = {}
  @next_uuid = 0
  # end

  def self.upload_file(file)
    uuid = @next_uuid.to_s.rjust(16, '0').to_sym
    uploader = Uploader.new(file, uuid)
    @next_uuid += 1
    @cache[uuid] = uploader
    uploader.async.upload
    uuid.to_s
  end

  def add_url_to_cache(uuid, url)
    @cache[uuid.to_sym] = url
  end

  def self.get_url_from_cache(uuid)
    uploader = @cache.delete uuid.to_sym

    if uploader.nil?
      nil
    elsif uploader.url.nil?
      ''
    else
      uploader.url
    end
  end

end