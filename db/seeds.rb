Event.destroy_all
Organization.destroy_all
User.destroy_all

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
    address: Faker::Address.street_address,
    overview: Faker::FamilyGuy.character,
    employees: rand(50..100),
    tech_team_size: rand(3..10),
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
    s_t = DateTime.now
    e_t = DateTime.now + 1.hour
    # s_t = rand(0..1000)
    # e_t = s_t + 3
    Event.create(
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph,
      location: Faker::FamilyGuy.character,
      start_time: s_t,
      end_time: e_t,
      organization_id: organization.id
    )
  end
end


events = Event.all

puts Cowsay.say("Create #{events.count} events", :moose)

["Javascript", "Java", "Ruby", "Rails", "HTML", "CSS"].each do |t|
  Tag.create(
    name: t
  )
end

puts "Use #{super_user.email} and #{PASSWORD} for testing"
