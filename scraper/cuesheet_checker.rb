class CuesheetChecker

  def check_cuesheets(directory)
    cuesheets = Dir.glob("#{directory}/**/*.cue")
    cuesheets.each do |cuesheet|
      cuesheet_file = File.open(cuesheet, "r")
      input_file = cuesheet_file.read
      input_file.encode!('UTF-16', :undef => :replace, :invalid => :replace, :replace => "?")
      input_file.encode!('UTF-8')
      cuesheet_file.close
      puts input_file
      cuesheet_file = File.open(cuesheet, "w")
      cuesheet_file.write(input_file)
      cuesheet_file.close
    end
  end

end

CuesheetChecker.new.check_cuesheets(Dir.pwd)
