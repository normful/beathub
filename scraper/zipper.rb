require 'rubygems'
require 'zip'

class Zipper

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
          begin
            zip_folder("#{this_folder}/split/", "#{this_folder}/#{zip_file}")
          rescue Zip::EntryExistsError
            puts "#{zip_file} already exists. Skipping."
          end
        end
      end
    end
  end

  def zip_folder(folder, zip)
    puts "Creating #{zip}"
    Zip::File.open(zip, Zip::File::CREATE) do |zipfile|
      Dir[File.join(folder, '**', '**')].sort.each do |file|
        puts "Adding #{file}"
        zipfile.add(file.sub(folder, ''), file)
      end
    end
  end

end

Zipper.new.walk(Dir.pwd)
