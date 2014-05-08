require 'taglib'
require 'Scrobbler2'
require 'open-uri' #downloads the image
require 'rdio' #will need to include om.rb and rdio.rb in githib if ever upload

Scrobbler2::Base.api_key = ""
Scrobbler2::Base.api_secret = ""
rdio = Rdio.new(["", ""])

#need to remove apostrophes and check what other characters are incompatable 


def search_lastfm(artist_name, song_name)
  image_link = ""
  album_name = ""

  track = Scrobbler2::Track.new(artist_name, song_name)
  album_name = track.info["album"]["title"]
  puts "album name: #{album_name}"
  album = Scrobbler2::Album.new(artist_name, album_name)
  #searching for the album cover from the track only gives 300x300 pictures; I use the album name found from the 
  #track info to plug a search for the album
  #4/22/2014 - may need another way to search up album name from just artist and song name - another api?

  puts "name: #{track.info["name"]}"
  puts "album: #{track.info["album"]["image"]}"
  puts "artist: #{track.info["artist"]}"
  puts "release date: #{track.info["releasedate"]}"
  puts "play count: #{track.info["playcount"]}"
  print "image: #{track.info["image"]}"

  print "Album: #{album.info["image"]}"
  #puts "Artist: #{album.info["artist"]}"
  #puts "Listeners: #{album.info["listeners"]}"
  #puts "URL: #{album.info["url"]}"
  #puts "Release Date: #{album.info["releasedate"]}"
  #puts "Play Count: #{album.info["playcount"]}"
  #puts 
  #puts
  #image_test = album.info["image"][4]["#text"]
  #puts "image test: #{image_test}"
  #File.open("link.txt", 'w') {|f| f.write(image_test) }

  begin
    @album.info["image"].each do |hash|
      if hash["size"] == "mega"
        image_link = hash["#text"]
      end
    end

    if image_link != ""
      return image_link
    else
      return false
    end

  rescue
    return false
  end

  
end


def search_rdio


end



def fix_id3

  TagLib::MPEG::File.open("11 - Not A Bad Thing.mp3") do |file|

    tag = file.id3v2_tag
    #get initial information first
    artist_name = tag.artist
    album_name = tag.album

    tag.frame_list.each {|frame| tag.remove_frame(frame)}


    # Read basic attributes
    
    properties = file.audio_properties
    puts tag.artist
    tag.artist = album.info["artist"]
    puts tag.artist

    puts "--" * 10
    puts tag.album
    tag.album = album.info["name"]
    puts tag.album
    puts "--" * 10

   
  #  cover = tag.frame_list("APIC").first
  #  puts cover.mime_type
  #  puts cover.description
  #  puts cover.type

    image_link = search_lastfm("")

    File.open("cover.jpg", 'wb') do |fo|
      fo.write open(image_link).read 
    end

    apic = TagLib::ID3v2::AttachedPictureFrame.new
    apic.mime_type = "image/jpeg"
    apic.description = "Cover"
    apic.type = TagLib::ID3v2::AttachedPictureFrame::FrontCover
    apic.picture = File.open("cover.jpg", "rb") {|f| f.read}
    tag.add_frame(apic)





    #puts Dir.pwd


    puts tag.frame_list
   
    file.save(TagLib::MPEG::File::AllTags, false)

    
  end



end




