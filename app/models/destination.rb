require 'json'
require 'nokogiri'
require 'open-uri'

class Destination < ApplicationRecord
    has_many :favorites, dependent: :destroy
    has_many :users, through: :favorites
    has_many :likes, dependent: :destroy

    # def self.scrape
    #     doc = Nokogiri::HTML(open('https://www.travelpulse.com/gallery/destinations/2021s-top-us-and-international-summer-travel-destinations.html'))
    #     byebug
    # end 

    def city_name
        name.split(',')[0]
    end

    def place_id
        gm_place_search_url= "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{self.city_name}&inputtype=textquery&key=#{ENV['GM_KEY']}"
        response = Faraday.get gm_place_search_url
        res = JSON.parse(response.body)
        res["candidates"][0]["place_id"]
    end

    def photoref_array
        gm_detail_url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{self.place_id}&fields=photos&key=#{ENV['GM_KEY']}"
        response = Faraday.get gm_detail_url
        res = JSON.parse(response.body)
        res["result"]["photos"].map{|p| p["photo_reference"]}
    end 

    def photo_array 
        photoref_array.map do |ref|
            gm_photo_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=800&photoreference=#{ref}&key=#{ENV['GM_KEY']}"
            response = Faraday.get gm_photo_url
            response.headers["location"]
        end
    end 

    def reviews
        gm_detail_url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{self.place_id}&fields=reviews,rating,user_ratings_total&key=#{ENV['GM_KEY']}"
        response = Faraday.get gm_detail_url
        res = JSON.parse(response.body)
        res["result"]["reviews"]
    end 

    def rating 
        gm_detail_url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{self.place_id}&fields=reviews,rating,user_ratings_total&key=#{ENV['GM_KEY']}"
        response = Faraday.get gm_detail_url
        res = JSON.parse(response.body)
        res["result"]["rating"]
    end

    def user_ratings_total 
        gm_detail_url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{self.place_id}&fields=reviews,rating,user_ratings_total&key=#{ENV['GM_KEY']}"
        response = Faraday.get gm_detail_url
        res = JSON.parse(response.body)
        res["result"]["user_ratings_total"]
    end

end
