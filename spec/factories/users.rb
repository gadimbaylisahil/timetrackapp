FactoryGirl.define do
	sequence :email do |n|
		"test#{n}@test.com"
	end

	factory :user do
		first_name 'TestName'
		last_name 'TestSurname'
		email { generate :email }
		password "123456"
		password_confirmation "123456"
		phone "0034631703581"
	end

	factory :non_authorized_user, class: 'User' do
		first_name 'TestName'
		last_name 'NonAuthorized'
		email { generate :email }
		password "123456"
		password_confirmation "123456"
		phone "0034631703581"
	end

	factory :admin_user, class: "AdminUser" do
		first_name 'Admin'
		last_name 'User'
		email { generate :email }
		password "123456"
		password_confirmation "123456"
		phone "0034631703581"
	end
end