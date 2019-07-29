10.times do
  City.create(
    name: Faker::Address.city
    )
end

TypeTravelPlace.create(
  name: "Hotels"
)
TypeTravelPlace.create(
  name: "Restaurants"
)

cities = City.order(:created_at).take(Faker::Number.within(1..3))
type_travel_places = TypeTravelPlace.order(:created_at)
cities.each do |city|
  type_travel_places.each do |type_travel_place|
    5.times do
      TravelPlace.create! name: Faker::Restaurant.name,
        content: Faker::Restaurant.description,
        address: Faker::Address.street_address,
        rate: Faker::Number.between(1,5),
        city_id: city.id,
        type_travel_place_id: type_travel_place.id
    end
  end
end

travel_places = TravelPlace.order(:created_at)
travel_places.each do |travel_place|
  3.times do
    TravelPlaceImage.create! link: Faker::LoremPixel.image,
      travel_place_id: travel_place.id
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

9.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! username:  name,
    email: email,
    gender: Faker::Gender.binary_type,
    date_of_birth: Faker::Date.between(50.years.ago, 10.years.ago),
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
end

users = User.order(:created_at).take(4)
travel_places = TravelPlace.order(:created_at).take(Faker::Number.within(1..4))
users.each do |user|
  travel_places.each do |travel_place|
    Post.create! title: Faker::Lorem.sentence(3, true, 4),
      content: Faker::Lorem.paragraph(2, false, 4),
      vote_point: Faker::Number.between(1,5),
      view: Faker::Number.number(3),
      user_id: user.id,
      travel_place_id: travel_place.id
  end
end

30.times do
  Post.create! title: Faker::Lorem.sentence(3, true, 4),
        content: Faker::Lorem.paragraph(2, false, 4),
        vote_point: Faker::Number.between(1,5),
        user_id: 1,
        travel_place_id: Faker::Number.between(1,5)
end

posts = Post.order(:created_at)
posts.each do |post|
  3.times do
    PostImage.create! link: Faker::LoremPixel.image("350x283", true),
      post_id: post.id
  end
end

ReactionType.create(
  description: "like"
  )
posts.each do |post|
  users = User.order(:created_at).take(Faker::Number.within(1..4))
    users.each do |user|
      Comment.create! content: Faker::Lorem.sentence,
        user_id: user.id,
        post_id: post.id

      Reaction.create! reaction_type_id: 1,
        user_id: user.id,
        post_id: post.id
    end
end

ReactionType.create(
  description: "like"
)

posts.each do |post|
  users.each do |user|
    Reaction.create! reaction_type_id: 1,
      user_id: user.id,
      post_id: post.id
  end
end
