# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :restaurants do
  primary_key :id
  String :title
  String :description, text: true
  String :enjoyedon
  String :location
end
DB.create_table! :reviews do
  primary_key :id
  foreign_key :restaurant_id
  foreign_key :user_id
  Boolean :checkin
  String :name
  String :email
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
restaurants_table = DB.from(:restaurants)

restaurants_table.insert(title: "Steamboat Barbecue", 
                    description: "Local, hole in the wall spot for great barbecue!",
                    enjoyedon: "June 21",
                    location: "322 E Geneva Rd, Wheaton, IL")

restaurants_table.insert(title: "Fire + Wine", 
                    description: "Neopolitan pizza and Italian small plates!.",
                    enjoyedon: "July 4",
                    location: "433 N Main St, Glen Ellyn, IL")
restaurants_table.insert(title: "The Burger Social", 
                    description: "Very messy burgers, great tap list, and nice ambiance!.",
                    enjoyedon: "July 4",
                    location: "108 N Hale St, Wheaton, IL")   
restaurants_table.insert(title: "Alfie's Inn", 
                    description: "Comfort food, dated interior, but great option for takeout!.",
                    enjoyedon: "July 4",
                    location: "425 Roosevelt Rd, Glen Ellyn, IL")   
