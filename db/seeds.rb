# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@user = User.create(email: "test@test.com", password: "123456", password_confirmation: "123456", first_name: "TestName", last_name: "TestSurname")
puts "Test User has been created"

50.times do |post|
	Post.create!(date: Date.today, rationale: "#{post} rationale", user_id: @user.id)
end
puts "100 posts have been created"