get '/' do
  @livesets = Liveset
    .paginate(:page => params[:page])
    .order(date_aired: :desc)
  erb :home
end

get '/search' do
  query = params[:query]
  @livesets = Liveset
    .where("lower(artist) LIKE lower(?) OR lower(title) LIKE lower(?)", "%#{query}%","%#{query}%")
    .paginate(page: params[:page], per_page: 50)
    .order(date_aired: :desc)
  # TODO: Also search through tracks that have the search query with pagination
  erb :search
end

get '/liveset/:id/?' do
  puts "TEST: #{ENV['TWITTER_API_KEY']}"
  twitter_client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_API_KEY']
    config.consumer_secret = ENV['TWITTER_API_SECRET']
    config.access_token = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end
  @liveset = Liveset.find(params[:id])
  @tracks = Track.where(liveset_id_workaround: params[:id].to_i).order(track_number: :asc)
  suckr = ImageSuckr::GoogleSuckr.new
  @image_url = suckr.get_image_url({
    "q" => "#{@liveset.artist}",
    "imgsz" => "large",
    "safe" => "active"
  })
  @tweets = twitter_client.search("#{@liveset.artist}", :result_type => "recent").take(5)
  erb :'liveset/show'
end
