require 'sinatra/base'
require 'logger'
require './utils.rb'
require './upload_cache.rb'

require 'sinatra/reloader'

class Modular < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  def initialize
    super
    @logger = Logger.new(STDOUT)
  end

  get '/' do
    @file = 'upload.html'
    erb :'template.html'
  end

  post '/upload' do
    file = params[:file]

    # @cache = UploadCache.new if @cache.nil?
    # @logger.info(@cache.nil?)

    if valid? file[:filename]
      @file = 'uuid.html'
      @uuid = UploadCache.upload_file file[:tempfile]
    else
      @file = 'error.html'
      @msg = 'Invalid file'
    end

    erb :'template.html'
  end

  get '/uuid' do
    @uuid = params[:uuid]

    @logger.info(@cache.nil?)
    @url = UploadCache.get_url_from_cache @uuid
    @file = 'uuid.html'

    @msg = 'Invalid, expired link/uuid or file not uploaded yet' if @url.nil?

    erb :'template.html'
  end

  run!

end