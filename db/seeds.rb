
Event.destroy_all
Organization.destroy_all
User.destroy_all
Tag.destroy_all
Tagging.destroy_all

PASSWORD = '123'

super_user = User.create(
  first_name: 'a',
  last_name: 'a',
  email: 'a@a.a',
  password: PASSWORD,
  is_admin: true
)

80.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all

puts Cowsay.say("Create #{users.count} users", :tux)

users.each do |user|
  Organization.create(
    name: Faker::FamilyGuy.character,
    address: "Vancouver, BC #{postalCodesVan[rand(0..354)]}, Canada",
    latitude: 49.2780017  + (rand(1000) / 10000.0),
    longitude: -123.1203521 + (rand(1000) / 10000.0),
    overview: Faker::FamilyGuy.character,
    employees: rand(50..100),
    tech_team_size: rand(10..25),
    website: Faker::Book.title,
    twitter: Faker::Code.asin,
    logo: Faker::Company.logo,
    published: true,
    user_id: user.id
  )
end

organizations = Organization.all
puts Cowsay.say("Created #{organizations.count} organizations", :ghostbusters)

organizations.each do |organization|
  rand(1..3).times.each do
    s_t = DateTime.new(2018,1,20,8) + rand(1...12).hours + rand(1...100).days
    e_t = s_t + rand(1...4).hours
    Event.create(
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph,
      # TODO change into a location using Faker::Address
      location: Faker::FamilyGuy.character,
      start_time: s_t,
      end_time: e_t,
      organization_id: organization.id
    )
  end
end


events = Event.all

puts Cowsay.say("Created #{events.count} events", :moose)

["Javascript", "Java", "Ruby", "Rails", "HTML", "CSS"].each do |t|
  Tag.create(
    name: t
  )
end


puts "Use #{super_user.email} and #{PASSWORD} for testing"

tags = Tag.all
# Seeding Taggings
organizations.each do |organization|
  rand(1..3).times.each do
    Tagging.create(
      organization_id: organizations.sample.id,
      tag_id: tags.sample.id
    )
  end
end

taggings = Tagging.all
puts "===================Create #{taggings.count} taggings====================="
