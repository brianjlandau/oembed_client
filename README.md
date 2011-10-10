# oEmbed Client

A simple abstract oEmbed Client for ruby.

## Install

    gem install oembed_client
    
Or in your `Gemfile`:

    gem 'oembed_client'

## Usage

Creating your own subclass:

    require 'oembed_client'
    
    class YoutubeOembedClient < OembedClient
      base_url 'http://www.youtube.com/oembed'
      default_options iframe: '1', maxwidth: '520'
    end
    
    c = YoutubeOembedClient.new('http://www.youtube.com/watch?v=4r7wHMg5Yjg')
    c.embed_html # => "<iframe ..."

Automagically create a new class for a oEmbed service URL:

    require 'oembed_client'
    
    OembedClient.create_client_class_for('http://www.flickr.com/services/oembed')
    c = OembedClient::Flickr.new('http://www.flickr.com/photos/brianlandau/6173724585/in/photostream')
    c.url # => "http://farm7.static.flickr.com/6174/6173724585_8a984a740b.jpg"

## Contributing to oembed_client
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Copyright

Copyright (c) 2011 Brian Landau. See LICENSE.txt for
further details.
