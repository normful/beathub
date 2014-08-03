require 'rubygems'
require 'mechanize'

class Scraper

  MUSIC_FOLDER = "#{Dir.pwd}/music"

  def initialize
    @agent = Mechanize.new
  end

  def scrape
    1.upto(5) { |i| save_mp3s(i) }
  end

  def save_mp3s(page_number)
    @agent.get("http://www.livesets.us/?p=#{page_number}")
    @agent.page.links_with(href: /^.+\.shtml$/, text: /^.+\s-\s.+$/).each do |link|
      liveset_page = link.click
      mp3_link = liveset_page.link_with(href: /^.*livesets.us\/d\;.*\.mp3$/)
      mp3_file = mp3_link.click
      mp3_filename = mp3_file.filename
      puts "Downloading #{mp3_filename}"
      mp3_folder = "#{MUSIC_FOLDER}/#{mp3_file.filename.chomp(".mp3")}"
      mp3_file.save "#{mp3_folder}/#{mp3_filename}"
      puts "Saving in #{MUSIC_FOLDER}/#{mp3_folder}/#{mp3_filename}"
      begin
        save_exact_matching_cue(mp3_filename, mp3_folder)
      rescue StandardError => e
        e.inspect
        save_best_matching_cue(link.text, mp3_folder)
      end
    end
  end

  def save_exact_matching_cue(query, mp3_folder)
    @agent.get('http://cuenation.com/?page=search')
    @agent.page.forms[1]["filename"] = query
    @agent.page.forms[1].submit
    cue_link = @agent.page.link_with(href: /^download\.php\?type=cue.*.cue$/)
    cue_file = cue_link.click # downloads the file
    puts "Downloading #{cue_file.filename}"
    cue_file.save "#{mp3_folder}/#{cue_file.filename}"
    puts "Saving in #{mp3_folder}/#{cue_file.filename}"
  end

  def save_best_matching_cue(query, folder)
    # TODO:
    # 1. Split query with delimiter "\ -\ "
    # 2. Use fragments to generate best match rating based on:
    # - match of artist name and it's alternative spellings
    # - match of title text
    # - match of title radio show sequence number, if it exists
    # - match of date and its alternative formats
  end

end

Scraper.new.save_mp3s(1)
