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

10.times do
  TravelPlace.create(
    name: Faker::Restaurant.name,
    content: Faker::Restaurant.description,
    address: Faker::Address.street_address,
    type_travel_place_id: Faker::Number.between(0,3),
    city_id: Faker::Number.between(1,10)
    )
end

User.create! username:  "admin",
             email: "admin@gmail.com",
             gender: "male",
             date_of_birth: "1/1/2018",
             password: "admin123",
             password_confirmation: "admin123",
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

10.times do
  Post.create(
    title: Faker::Lorem.sentence(3, true, 4),
    content: Faker::Lorem.paragraph(2, false, 4),
    vote_point: Faker::Number.between(1,5),
    user_id: Faker::Number.between(2,9),
    travel_place_id: Faker::Number.between(2,5)
    )
end

10.times do
  TravelPlaceImage.create(
    link: Faker::LoremPixel.image,
    travel_place_id: Faker::Number.between(0,11)
    )
end

10.times do
  PostImage.create(
    link: Faker::LoremPixel.image,
    post_id: Faker::Number.between(0,11)
    )
end
