get '/' do
  erb :home
  @livesets = Liveset.all
end

post '/search' do
  search = params[:query]
  @livesets = Liveset.where("artist LIKE ? OR title LIKE ?", "%#{search}%","%#{search}%","%#{search}%")
  erb :search
end

get '/set/:id' do
  @liveset = Liveset.find(params[:id])
  erb :'set/show'
end
