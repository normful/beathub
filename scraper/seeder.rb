require_relative '../config/environment'
require 'mp3info'
require 'dotenv'

class Seeder

  FILESERVER = "http://music.beathub.ca/"

  def initialize
    Dotenv.load
    ActiveRecord::Base.clear_connection_cache!
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

  def create_tracks(start)
    Dir.foreach(start) do |x|
      path = File.join(start, x)
      if x == "." or x == ".."
        next
      elsif File.directory?(path)
        create_tracks(path)
      else
        if x =~ /\.mp3/ && File.dirname(path).split("/").last == "split"
          create_track(path)
        end
      end
    end
  end

  def create_track(track_path)
    hash = {}
    a = track_path.split("/")
    set_folder = a[a.size - 3]
    file = a[a.size - 1]
    hash[:filepath] = FILESERVER + set_folder + "/split/" + file
    liveset_filepath = FILESERVER + set_folder + "/" + set_folder + ".mp3"
    Mp3Info.open(track_path) do |mp3|
        hash[:artist] = mp3.tag2["TPE1"]
        hash[:title] = mp3.tag2["TIT2"]
        hash[:track_number] = mp3.tag2["TRCK"].to_i
    end
    track = Track.create(hash)
    liveset = Liveset.where(filepath: liveset_filepath)
    liveset.tracks << track
    track.save!
  end

end

# Must run seeder in project root directory for now
Seeder.new.create_livesets(Dir.pwd + "/scraper/music/")
Seeder.new.create_tracks(Dir.pwd + "/scraper/music/")
