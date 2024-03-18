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
  Agent.find_or_create_by!(name: Faker::Name.name, email: Faker::Internet.email, base_commission: Faker::Number.decimal(l_digits: 2), contract_date: Faker::Date.between(from: 2.years.ago, to: Date.today))
  Seller.find_or_create_by!(name: Faker::Name.name, email: Faker::Internet.email)
  Buyer.find_or_create_by!(name: Faker::Name.name, email: Faker::Internet.email)
end
