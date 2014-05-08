AlbumCoverAssigner
==================
My ongoing project that seeks to correct my library of MP3s with ID3 tags that are broken or have been poorly assigned. My biggest problem are the album covers, some of which are empty and some of which are not assigned properly. This is especially annoying when Android likes to assign random album covers to songs that do not already have any cover art. This script will hopefully use a combination of the song name, song artist and album name pulled from their ID3 tags to search databases such as [rdio](www.rdio.com) and [last.fm](www.last.fm) to pull metadata about the song and assign them to their proper catagories. 




Usage
------

This script currently requires several external APIs:

[Taglib](http://robinst.github.io/taglib-ruby/)

    A library for ruby to access and edit ID3 tags of MP3s.
    
    gem install taglib-ruby 
    
[Scrobbler2](https://github.com/gingerhendrix/scrobbler2)

    An API for ruby to access the web services of last.fm, including music metadata and album covers.
    
    gem install gingerhendrix-scrobbler2

[rdio-simple](https://github.com/rdio/rdio-simple/tree/master/ruby)

    An API for ruby to access the rdio web services. 
    Include om.rb and rdio.rb in source files
    

[open-uri](http://ruby-doc.org/stdlib-1.9.3/libdoc/open-uri/rdoc/OpenURI.html)
    
    
    Used to download images from the links provided by web services and included in Ruby
    
    require 'open-uri'


To do
------

Lots. 

Currently, the last.fm database works fine, but requires an Album Name and Artist Name in order to access the 'mega' (600 x 600) images that I would like for my MP3s. This is not a great solution as many of my songs are missing either the Album Name or Artist Name. Searching by Artist Name and Song Name often has a better chance of success, but for some reason these searches only produce tiny album cover links (300 x 300) on last.fm. Trying to find the album name from the metadata found from a Artist Name and Song Name search sometimes provides weird albums (many of my songs are Electronic Dance Music and there are many rereleases on albums such as 'Top 40 Hit Albums' that it often does not give me the original album). 
Finally, some of my songs only have a Song Name, which is even more difficult to search databases with. 

Currently, I am trying to use other libraries to fill in the gaps that last.fm cannot find. Right now I am working with the rdio API to hopefully find a better solution to these problems. My hope is for this script in the future to query several databases until it find a suitable album cover for the MP3. One issue to remember are the different restrictions on the number of calls to the databases per second and per day. I would need to implement code that slows the calls to be within these guidelines. Also, databases that place restrictions on the number of calls per day would not be ideal for my script.

Another idea is to use the file name to find Album Names or Song Names, as some songs tend to put this information into the file name itself. 

