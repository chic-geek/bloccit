require 'faker'

## =================================================
## CREATE USERS
## =================================================
## call user.new rather than .create as this instance isn't then
## immediately saved to the db, because we'd like to skip
## confirmation at this fake data point.
## -------------------------------------------------
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

## =================================================
## CREATE TOPICS
## =================================================
15.times do
  Topic.create!(
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph
  )
end
topics = Topic.all

## =================================================
## CREATE POSTS
## =================================================
50.times do
  post = Post.create!(
    user:  users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )

  # setting the created at time to a time within th past year
  post.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
  post.create_vote
  post.update_rank
end
posts = Post.all

## =================================================
## CREATE COMMENTS
## =================================================
100.times do
  Comment.create!(
    user: users.sample, # in prep for associating Users with Comments
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end


## =================================================
## CREATE USERS
## =================================================
## use .skip_confirmation! method to avoid devises'
## fully confirming email functionality.
## -------------------------------------------------

# Create an admin user
admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)
admin.skip_confirmation!
admin.save!

# Create a moderator user
moderator = User.new(
  name:     'Moderator User',
  email:    'moderator@example.com',
  password: 'helloworld',
  role:     'moderator'
)
moderator.skip_confirmation!
moderator.save!

# Create a member user
member = User.new(
  name:     'Member User',
  email:    'member@example.com',
  password: 'helloworld'
)
member.skip_confirmation!
member.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{User.first.name} is the first user in the db, with the email address of #{User.first.email}"
