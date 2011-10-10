require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'
require 'vcr'
require 'webmock'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'oembed_client'

class YoutubeOembedClient < OembedClient
  base_url 'http://www.youtube.com/oembed'
  default_options :iframe => '1', :maxwidth => '520'
end

VCR.config do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.stub_with :webmock
  c.default_cassette_options = { :record => :once }
  c.allow_http_connections_when_no_cassette = true
end

class Test::Unit::TestCase
end
