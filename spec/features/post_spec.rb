require 'rails_helper'

describe 'navigate' do
	let(:user) { FactoryGirl.create(:user) }

	let(:post) do 
		Post.create(date: Date.today, rationale: "Rationale", user_id: user.id, overtime_request: 3.5)
	end

	before do
		login_as(user, :scope => :user)
	end 
	describe 'index' do
		before do 
			visit posts_path
		end

		it 'can be reached successfully' do
			expect(page.status_code).to eq(200)
		end

		it 'has a title of Posts' do
			expect(page).to have_content(/Posts/)
		end

		it 'has a list of posts' do
			post1 = FactoryGirl.build_stubbed(:post)
			post2 = FactoryGirl.build_stubbed(:second_post)
			visit posts_path
			expect(page).to have_content(/Rationale|Example/)
		end

		it 'only lets post creators to see their own posts' do 
			post1 = Post.create(date: Date.today, rationale: "some rationale", user_id: user.id)
			post1 = Post.create(date: Date.today, rationale: "some rationale", user_id: user.id)

			other_user = User.create(first_name: 'Test', last_name: "TestSurname", email: "some@some.com", password: "123456", password_confirmation: "123456", phone: "5555555")
			post_from_other_user = Post.create(date: Date.today, rationale: "some rationale shouldnt be seen", user_id: other_user.id, overtime_request: 3.5)
			
			visit posts_path
			expect(page).to_not have_content(/some rationale shouldnt be seen/)
		end
	end

	describe 'new' do
		it 'has a link from the homepage' do
	      	employee = Employee.create(first_name: 'Employee', last_name: 'Authorized', email: "employee@example.com", password: "asdfasdf", password_confirmation: "asdfasdf", phone: "5555555555")
	      	login_as(employee, :scope => :user)
	      	visit root_path
			click_link("new_post_from_nav") 
			expect(page.status_code).to eq(200)
		end
	end

  describe 'delete' do
    it 'can be deleted' do
    	logout(:user)

    	user_to_delete = FactoryGirl.create(:user)
    	login_as(user_to_delete, :scope => :user)

    	post_to_delete = Post.create(date: Date.today, rationale: "Rationale", user_id: user_to_delete.id, overtime_request: 3.5)
      visit posts_path

      click_link("delete_post_#{post_to_delete.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end

	describe 'creation' do
		before do
			visit new_post_path
		end

		it 'has a new form that can be reached' do
			expect(page.status_code).to eq(200)
		end

		it 'can be created from new form page' do
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rationale]', with: "rationale"
			fill_in 'post[overtime_request]', with: "4.5"
			expect { click_on "Save" }.to change(Post, :count).by(1)
		end

		it 'will have a user associated with it' do
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rationale]', with: "User_Association"
			fill_in 'post[overtime_request]', with: "4.5"
			click_on "Save"
			expect(User.last.posts.last.rationale).to eq("User_Association")
		end
	end

	describe 'edit' do

		it 'can be edited' do 
			visit edit_post_path(post)
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rationale]', with: "Edited Content"
			click_on "Save"
			expect(page).to have_content("Edited Content")
		end

		it 'cannot be edited by a non-admin or non-authorized user' do 
			logout(:edit_user)
			non_authorized_user = FactoryGirl.create(:non_authorized_user)
			login_as(non_authorized_user, :scope => :user)
			
			visit edit_post_path(post)

			expect(current_path).to eq(root_path)
		end 
	end
end