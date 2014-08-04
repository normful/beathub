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
        this_folder = File.dirname(path)
        zip_file = "#{x.chomp(".cue")}.zip"
        zip_folder("#{this_folder}/split/", "#{this_folder}/#{zip_file}")
      end
    end
  end
end

def zip_folder(folder, zip)
  Zip::File.open(zip, Zip::File::CREATE) do |zipfile|
      Dir[File.join(folder, '**', '**')].each do |file|
        zipfile.add(file.sub(folder, ''), file)
      end
  end
end

walk(Dir.pwd)
