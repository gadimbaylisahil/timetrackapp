FactoryGirl.define do 
	factory :post do
		date Date.today
		rationale "Rationale Example"
	end
	factory :second_post, class: "Post" do
		date Date.yesterday
		rationale "Rationale Example 2"
	end
	factory :third_post, class: "Post" do
		date Date.tomorrow
		rationale "Rationale Example 3"
	end
end