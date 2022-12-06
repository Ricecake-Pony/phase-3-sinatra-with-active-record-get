class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])
    # game.to_json(include: :reviews) This shows the reviews associated with the game
    # game.to_json(include: { reviews: { include: :user } }) Can include user associations too with the nested hash
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
    # look up the game in the database using its ID
    # send a JSON-formatted response of the game data
  end


end
