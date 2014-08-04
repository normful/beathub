require_relative '../config/environment'
require 'mp3info'
require 'dotenv'

class Seeder

  FILESERVER = "http://music.beathub.ca/"

  def initialize
    Dotenv.load
    ActiveRecord::Base.establish_connection(
      :adapter  => 'postgresql',
      :host     => ENV["PG_HOST"],
      :database => ENV["PG_DATABASE"],
      :username => ENV["PG_USERNAME"],
      :password => ENV["PG_PASSWORD"],
      :encoding => "utf8"
    )
  end

  def create_livesets(start)
    Dir.foreach(start) do |x|
      path = File.join(start, x)
      if x == "." or x == ".."
        next
      elsif File.directory?(path)
        create_livesets(path)
      else
        if x =~ /\.mp3/ && File.dirname(path).split("/").last != "split"
          create_liveset(path)
        end
      end
    end
  end

  def create_liveset(liveset_path)
    hash = {}
    a = liveset_path.split("/")
    folder = a[a.size - 2] + "/"
    file = a[a.size - 1]
    hash[:filepath] = FILESERVER + folder + file
    Mp3Info.open(liveset_path) do |mp3|
      hash[:artist] = mp3.tag2["TPE1"]
      hash[:title] = mp3.tag2["TIT2"]
    end
    local_cue_path = liveset_path.gsub(/\.mp3$/, ".cue")
    local_zip_path = liveset_path.gsub(/\.mp3$/, ".zip")
    if File.file?(local_cue_path)
      hash[:cuepath] = FILESERVER + folder + file.gsub(/\.mp3$/, ".cue")
    end
    if File.file?(local_zip_path)
      hash[:zippath] = FILESERVER + folder + file.gsub(/\.mp3$/, ".zip")
    end
    Liveset.create!(hash)
  end

  # def create_track(filepath)
  #   Mp3Info.open(filepath) do |mp3|
  #     Track.create(
  #       artist: mp3.tag2["TPE1"],
  #       title: mp3.tag2["TIT2"],
  #       filepath: filepath,
  #       track_number: mp3.tag2["TRCK"].to_i
  #     )
  #     # TODO: Assign Track to Liveset
  #   end
  # end

end

# Must run seeder in project root directory for now
Seeder.new.create_livesets(Dir.pwd + "/scraper/music/")
# Seeder.new.create_tracks(Dir.pwd + "/scraper/music/")
