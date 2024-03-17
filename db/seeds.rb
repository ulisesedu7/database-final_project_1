# Initialize the main user
User.find_or_create_by!(email: "ulises@email.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "Ulises"
  user.last_name = "Largaespada"
  user.role = 0
end

# Initialize the second user
User.find_or_create_by!(email: "eduardo@email.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "Eduardo"
  user.last_name = "Reyes"
  user.role = 1
end

# Initialize the third user
User.find_or_create_by!(email: "linda@email.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "Linda"
  user.last_name = "Mairena"
  user.role = 1
end

# Initialize the fourth user
User.find_or_create_by!(email: "liam@email.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.first_name = "Liam"
  user.last_name = "Neeson"
  user.role = 1
end
