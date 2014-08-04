require_relative '../config/environment'
require 'mp3info'

class TagUpdater

  def update_tags(start)
    Dir.foreach(start) do |x|
      path = File.join(start, x)
      if x == "." or x == ".."
        next
      elsif File.directory?(path)
        update_tags(path)
      else
        if x =~ /\.mp3/ && File.dirname(path).split("/").last != "split"
          update_liveset_tags(path)
        end
      end
    end
  end

  def update_liveset_tags(filepath)
    Mp3Info.open(filepath) do |mp3|
      if mp3.tag2["TPE1"].nil?
        puts "Updating tags #{filepath}"
        filename = filepath.split("/").last
        artist = filename.split("_-_")[0].gsub(/_presents$/, "").gsub(/_/, " ")
        title = filename.split("_-_")[1].chomp(".mp3").gsub(/_/, " ")
        mp3.tag2["TPE1"] = artist
        mp3.tag2["TIT2"] = title
        mp3.tag2["TALB"] = title
      end
    end
  end

end

TagUpdater.new.update_tags(Dir.pwd)
