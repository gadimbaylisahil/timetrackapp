FactoryGirl.define do 
	factory :post do
		date Date.today
		rationale "Rationale Example"
		user
	end
	factory :second_post, class: "Post" do
		date Date.yesterday
		rationale "Rationale Example 2"
		user
	end
end