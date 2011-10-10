require 'open-uri'
require 'cgi'
require 'multi_json'

class OembedClient
  attr_reader :url
  
  STANDARD_RESPONSE_PARAMS = %w(type version title author_name author_url provider_name
    provider_url cache_age thumbnail_url thumbnail_width thumbnail_height
    width height)
  
  class << self
    def create_client_class_for(url)
      client_name = URI.parse(url).host.split('.')[-2].capitalize
      klass = const_set(client_name, Class.new(self))
      klass.base_url(url)
      klass
    end
    
    def base_url(url = nil)
      if url.nil?
        @base_url
      else
        @base_url = url
      end
    end
    
    def default_options(options = nil)
      if options.nil?
        @default_options ||= {}
      else
        @default_options = options
      end
    end
  end
  
  def initialize(url, embed_options = {})
    @url = url
    @embed_options = embed_options
  end
  
  def omembed_url
    self.class.base_url+'?'+params
  end
  
  def params
    querify_params(self.class.default_options.merge(@embed_options).merge(:url => @url, :format => 'json'))
  end
  
  def fetch
    open(omembed_url)
  end
  
  def response
    @response ||= fetch.read
  end
  
  def json
    @json ||= MultiJson.decode(response)
  rescue
    @json = {}
  end
  
  def embed_html
    json['html']
  end
  
  def embed_url
    json['url']
  end
  
  %w(photo video link rich).each do |embed_type|
    define_method("#{embed_type}?") do
      type == embed_type
    end
  end
  
  STANDARD_RESPONSE_PARAMS.each do |attribute|
    define_method(attribute) do
      json[attribute]
    end
  end
  
  def method_missing(name, *args, &block)
    if json.keys.include?(name.to_s)
      json[name.to_s]
    else
      super
    end
  end
  
  private
  
  def querify_params(params)
    params.map {|key, value|
      "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
    }.join('&')
  end
end
