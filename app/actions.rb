# Homepage (Root path)
get '/' do
  erb :index
end

get '/results' do
  erb :results
end

get '/tracklist' do
  erb :tracklist
end
