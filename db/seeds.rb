# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@user = User.create(email: "regular@regular.com", password: "123456", password_confirmation: "123456", first_name: "Regular", last_name: "RegularSurname")
puts "Regular user has been created"

AdminUser.create(email: "admin@admin.com", password: "123456", password_confirmation: "123456", first_name: "Admin", last_name: "AdminSurname")
puts "Admin user has been created"

25.times do |post|
	Post.create!(date: Date.today, rationale: "#{post} rationale", user_id: @user.id)
end
puts "25 posts have been created"