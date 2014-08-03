require 'rubygems'
require 'zip'

def walk(start)
  Dir.foreach(start) do |x|
    path = File.join(start, x)
    if x == "." or x == ".."
      next
    elsif File.directory?(path)
      walk(path)
    else
      if x =~ /\.cue/
        split_folder "#{path}/#{x}/split"
        # TODO
      end
    end
  end
end

walk(Dir.pwd)
