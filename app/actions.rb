get '/' do
  erb :home
end

post '/' do
  redirect '/search'
end

get '/search' do
  erb :search
end

get '/set/:id' do
  erb :'set/show'
end

get '/results' do
  erb :results
end

get '/tracklist' do
  erb :tracklist
end
