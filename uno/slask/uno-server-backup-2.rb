require 'sinatra' 
require 'json' 
require 'UnoServer'

uno = UnoServer.new 

###### Sinatra Part ###### 

set :port, 8081
set :environment, :production 

get '/cards' do 
  return_message = {} 
  if params.has_key?('name') 
    cards = uno.get_cards(params['name']) 
    if cards.class == Array 
      return_message[:status] == 'success' 
      return_message[:cards] = cards 
    else 
      return_message[:status] = 'sorry - it appears you are not part of the game' 
      return_message[:cards] = [] 
    end 
  end 
  return_message.to_json 
end 

get '/count' do
  return_message = {}
  return_message[:status] == 'success' 
  return_message[:count] = 15 
  return_message.to_json
end


post '/join' do 
  return_message = {} 
  jdata = JSON.parse(params[:data],:symbolize_names => true) 
  if jdata.has_key?(:name) && uno.join_game(jdata[:name]) 
    return_message[:status] = 'welcome' 
  else 
    return_message[:status] = 'sorry - game not accepting new players' 
  end 
  return_message.to_json 
end 

post '/deal' do 
  return_message = {} 
  if uno.deal 
    return_message[:status] = 'success' 
  else 
    return_message[:status] = 'fail' 
  end 
  return_message.to_json 
end

