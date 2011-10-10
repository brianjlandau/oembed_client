require 'helper'

class TestOembedClient < Test::Unit::TestCase
  context 'OembedClient' do
    should "be able to create a new client class on it's own" do
      VCR.insert_cassette('flickr_response')
      OembedClient.create_client_class_for('http://www.flickr.com/services/oembed')
      OembedClient::Flickr.ancestors.include?(OembedClient)
      assert_equal 'http://www.flickr.com/services/oembed', OembedClient::Flickr.base_url
      c = OembedClient::Flickr.new('http://www.flickr.com/photos/brianlandau/6173724585/in/photostream')
      assert_equal 'http://farm7.static.flickr.com/6174/6173724585_8a984a740b.jpg', c.embed_url
      assert c.photo?
      VCR.eject_cassette
    end
    
    context 'for existing YouTube client with good response' do
      setup do
        VCR.insert_cassette('youtube_response')
        @client = YoutubeOembedClient.new('http://www.youtube.com/watch?v=4r7wHMg5Yjg')
      end

      should 'correctly report that it is a video' do
        assert @client.video?
      end

      should 'correctly report that it is not another type' do
        assert !@client.photo?
        assert !@client.link?
        assert !@client.rich?
      end

      should 'correctly report the title' do
        assert_equal 'The Crazy Nastyass Honey Badger (original narration by Randall)',
          @client.title
      end

      should 'correctly report the embed html' do
        assert_equal %q{<iframe width="459" height="344" src="http://www.youtube.com/embed/4r7wHMg5Yjg?fs=1" frameborder="0" allowfullscreen></iframe>},
          @client.embed_html
      end

      teardown do
        VCR.eject_cassette
      end
    end
    
    context 'for existing YouTube client with bad response' do
      setup do
        VCR.insert_cassette('youtube_bad_response')
        @client = YoutubeOembedClient.new('http://www.youtube.com/bogus')
      end
      
      should 'correctly report that it is not any type' do
        assert !@client.video?
        assert !@client.photo?
        assert !@client.link?
        assert !@client.rich?
      end
      
      should 'return nil for embed html' do
        assert_nil @client.embed_html
      end
      
      should 'return nil for title' do
        assert_nil @client.title
      end
      
      teardown do
        VCR.eject_cassette
      end
    end
  end
end
