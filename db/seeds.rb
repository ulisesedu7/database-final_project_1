# Place all the Users in an array data to then
users_array = [
  {email: "ulises@email.com", password: "UlisesLargaespada", password_confirmation: "UlisesLargaespada", first_name: "Ulises", last_name: "Largaespada", role: 0},
  {email: "eduardo@email.com", password: "EduardoReyes", password_confirmation: "EduardoReyes", first_name: "Eduardo", last_name: "Reyes", role: 1},
  {email: "linda@email.com", password: "LaMasBonita", password_confirmation: "LaMasBonita", first_name: "Linda", last_name: "Mairena", role: 1},
  {email: "liam@email.com", password: "password", password_confirmation: "password", first_name: "Liam", last_name: "Neeson", role: 1}
]

# Create the users
users_array.each do |user|
  User.find_or_create_by!(email: user[:email]) do |u|
    u.password = user[:password]
    u.password_confirmation = user[:password_confirmation]
    u.first_name = user[:first_name]
    u.last_name = user[:last_name]
    u.role = user[:role]
  end
end

# Create 5 agents, sellers and buyers with random data from FAKER
5.times do
  # Skip if there's already 5 agents, sellers and buyers
  next if Agent.count == 5 && Seller.count == 5 && Buyer.count == 5

  # Set the user_id that set the action for the audit logs as the super admin
  audited_user_id = User.find_by(email: "ulises@email.com").id

  # Set the audited_user_id to the Active Record variable
  ActiveRecord::Base.connection.execute("SET myapp.current_user_id TO '#{audited_user_id}';")

  Agent.find_or_create_by!(name: Faker::Name.name, email: Faker::Internet.email, base_commission: Faker::Number.decimal(l_digits: 2), contract_date: Faker::Date.between(from: 2.years.ago, to: Date.today))
  Seller.find_or_create_by!(name: Faker::Name.name, email: Faker::Internet.email)
  Buyer.find_or_create_by!(name: Faker::Name.name, email: Faker::Internet.email)

  # Reset the Active Record variable
  ActiveRecord::Base.connection.execute("RESET myapp.current_user_id;")
end

# Create 10 available properties with random data from FAKER and set them to a random agent and seller.
# Also set a random image from the images folder
10.times do
  # Skip if there's already 10 available properties
  next if AvailableProperty.count == 10

  # Set the user_id that set the action for the audit logs as the super admin
  audited_user_id = User.find_by(email: "ulises@email.com").id

  # Set the audited_user_id to the Active Record variable
  ActiveRecord::Base.connection.execute("SET myapp.current_user_id TO '#{audited_user_id}';")

  i = Faker::Number.between(from: 1, to: 7)

  # Get the valid ids of the agents and sellers to set them to the available property
  agent_ids = Agent.pluck(:id)
  seller_ids = Seller.pluck(:id)

  # Create an available property with a random image
  AvailableProperty.find_or_create_by!(
    name: Faker::Address.community,
    city: Faker::Address.city,
    address: Faker::Address.street_address,
    listed_price: Faker::Number.decimal(l_digits: 2),
    bedrooms: Faker::Number.between(from: 1, to: 5),
    has_pool: Faker::Boolean.boolean,
    publication_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
    agent_id: agent_ids.sample,
    seller_id: seller_ids.sample
  ) do |available_property|
    available_property.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', "property-#{i}.jpeg")), filename: "property-#{i}.jpeg", content_type: 'image/jepg')
  end

  # Reset the Active Record variable
  ActiveRecord::Base.connection.execute("RESET myapp.current_user_id;")
end

# Create 10 sold properties with random data from FAKER and set them to a random agent, seller and buyer.
# Also set a random image from the images folder
10.times do
  i = Faker::Number.between(from: 1, to: 7)

  # Set the user_id that set the action for the audit logs as the super admin
  audited_user_id = User.find_by(email: "ulises@email.com").id

  # Set the audited_user_id to the Active Record variable
  ActiveRecord::Base.connection.execute("SET myapp.current_user_id TO '#{audited_user_id}';")

  # Get the valid ids of the agents and sellers to set them to the available property
  agent_ids = Agent.pluck(:id)
  seller_ids = Seller.pluck(:id)
  buyer_ids = Buyer.pluck(:id)

  SoldProperty.find_or_create_by!(
    name: Faker::Address.community,
    city: Faker::Address.city,
    address: Faker::Address.street_address,
    sale_price: Faker::Number.decimal(l_digits: 2),
    bedrooms: Faker::Number.between(from: 1, to: 5),
    has_pool: Faker::Boolean.boolean,
    sale_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
    agent_commission: Faker::Number.decimal(l_digits: 2),
    agent_id: agent_ids.sample,
    buyer_id: buyer_ids.sample,
    seller_id: seller_ids.sample
  ) do |sold_property|
    sold_property.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', "property-#{i}.jpeg")), filename: "property-#{i}.jpeg", content_type: 'image/jepg')
  end

  # Reset the Active Record variable
  ActiveRecord::Base.connection.execute("RESET myapp.current_user_id;")
end
