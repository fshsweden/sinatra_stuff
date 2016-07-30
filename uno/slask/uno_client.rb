# Ruby Uno Client 

require 'json' 
require 'rest-client' 

class UnoClient 
  attr_reader :name 

  def initialize name 
    @name = name 
  end 

  def join_game 
    response = RestClient.post 'http://localhost:8080/join', 
                  :data => {name: @name}.to_json, 
                  :accept => :json 

    puts JSON.parse(response,:symbolize_names => true) 
  end 

  def get_cards 
    response = RestClient.get 'http://localhost:8080/cards', 
                  {
                    :params => {
                      :name => @name
                    }
                  } 
    puts response 
  end 

  def deal 
    response = RestClient.post 'http://localhost:8080/deal', 
                              :data =>{}.to_json, 
                              :accept => :json 
    puts response 
  end 

  def count 
    response = RestClient.get 'http://localhost:8080/count' 
                              
    puts response 
  end 
end



uc1 = UnoClient.new 'test'

uc1.count
uc1.join_game
uc1.deal

uc1.get_cards


