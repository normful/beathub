require_relative '../config/environment'

20.times do
  liveset = FactoryGirl.create :liveset
  1.upto(rand(9 .. 25)).each do |i|
    track = FactoryGirl.build(:track)
    a = liveset.filepath.split(/\//)
    track_folder = "#{a.first(a.size - 1).join("/")}"
    track.filepath = "#{track_folder}/#{track.artist} - #{track.title}.mp3"
    track.track_number = i
    track.save
    liveset.tracks << track
  end
end
