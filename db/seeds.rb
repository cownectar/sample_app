# Create a main sample user.
User.create!(name:  "Example User",
						 email: "example@railstutorial.org",
						 password:              "foobar",
						 password_confirmation: "foobar",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

# Generate a bunch of additional users.
99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  								name,
						 email: 								email,
						 password:              password,
						 password_confirmation: password)
end

# Generate microposts for a subset of users.
users = User.order(:created_at).take(6)
50.times do
	#Produces some retard bullshit
  content = Faker::Lorem.sentence(word_count: 5)
  #Posts the bullshit to each users micropost
  users.each { |user| user.microposts.create!(content: content) }
end

#Following Relationships
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed)}
followers.each { |follower| user.follow(user)}