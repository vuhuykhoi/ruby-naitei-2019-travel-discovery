10.times do
  City.create(
    name: Faker::Address.city
    )
end

TypeTravelPlace.create(
  name: "Hotels"
)
TypeTravelPlace.create(
  name: "Travel"
)
TypeTravelPlace.create(
  name: "Foods"
)

cities = City.order(:created_at).take(3)
type_travel_places = TypeTravelPlace.order(:created_at)
cities.each do |city|
  type_travel_places.each do |type_travel_place|
    5.times do
      TravelPlace.create! name: Faker::Restaurant.name,
        content: Faker::Restaurant.description,
        address: Faker::Address.street_address,
        rate_point: 2.5,
        city_id: city.id,
        type_travel_place_id: type_travel_place.id
    end
  end
end

travel_places = TravelPlace.order(:created_at)
travel_places.each do |travel_place|
  case travel_place.type_travel_place_id
    when 1
      3.times do |i|
        TravelPlaceImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/hotels/#{i+1}.jpg",
                       travel_place_id: travel_place.id
      end
    when 2
       4.times do |i|
        TravelPlaceImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/play_places/#{i+1}.jpg",
                       travel_place_id: travel_place.id
      end
    when 3
       5.times do |i|
        TravelPlaceImage.create! link: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/food/#{i+1}.jpg",
                       travel_place_id: travel_place.id
    end
  end
end

User.create! username:  "admin",
  email: "admin@gmail.com",
  gender: "male",
  date_of_birth: "1/1/2018",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now

10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! username:  name,
    email: email,
    gender: Faker::Gender.binary_type,
    date_of_birth: Faker::Date.between(from: 50.years.ago,to: 10.years.ago),
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
end

users = User.order(:id).take(2)
users.each do |user|
    7.times do
      Post.create! title: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 4),
                   content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
                   vote_point: Faker::Number.between(from: 1,to: 5),
                   view: Faker::Number.between(from: 1,to: 20),
                   user_id: user.id,
                   travel_place_id: Faker::Number.between(from: 1,to: 30)
    end
end

posts = Post.all
posts.each do |post|
   case post.travel_place.type_travel_place_id
    when 1
      3.times do |i|
        PostImage.create! remote_link_url: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/hotels/#{i+1}.jpg",
                       post_id: post.id
      end
    when 2
       2.times do |i|
        PostImage.create! remote_link_url: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/play_places/#{i+1}.jpg",
                       post_id: post.id
      end
    when 3
       3.times do |i|
        PostImage.create! remote_link_url: "https://res.cloudinary.com/hedspi/image/upload/v1564448966/travel-discovery/food/#{i+1}.jpg",
                       post_id: post.id
      end
    end
end

users = User.order(:created_at).take(5)
posts = Post.order(:created_at).take(10)
posts.each do |post|
  users.each do |user|
    Comment.create! content: Faker::Lorem.sentence,
      user_id: user.id,
      post_id: post.id
  end
end

ReactionType.create(
  description: "like"
)

reaction_type_id = ReactionType.first.id
users = User.order(:created_at).take(5)
posts = Post.order(:created_at).take(12)
posts.each do |post|
  users.each do |user|
    Reaction.create! reaction_type_id: reaction_type_id,
      user_id: user.id,
      post_id: post.id
  end
end

users = User.all
user  = users.first
following = users[2..5]
followers = users[3..9]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
