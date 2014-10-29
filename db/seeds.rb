require 'faker'

# Create Users
5.times do
  # call user.new rather than .create as this instance isn't then
  # immediately saved to the db, because we'd like to skip
  # confirmation at this fake data point.
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create the posts
50.times do
  Post.create!(
    user:  users.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )
end
posts = Post.all

# Create a few comments
100.times do
  Comment.create!(
    # user: users.sample, # in prep for associating Users with Comments
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end

User.first.update_attributes!(
  email: 'c.brett84@gmail.com',
  password: 'welcome123'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{User.first.name} is the first user in the db, with the email address of #{User.first.email}"
