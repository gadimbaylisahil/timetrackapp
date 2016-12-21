FactoryGirl.define do 
	factory :post do
		date Date.today
		rationale "Rationale Example"
		overtime_request 3.5 
		user
	end
	factory :second_post, class: "Post" do
		date Date.yesterday
		rationale "Rationale Example 2"  
		overtime_request 0.5
		user
	end
end