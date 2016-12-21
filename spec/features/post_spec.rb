require 'rails_helper'

describe 'navigate' do
	before do
		@user = FactoryGirl.create(:user)
		login_as(@user, :scope => :user)
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
			post1 = Post.create(date: Date.today, rationale: "some rationale", user_id: @user.id)
			post1 = Post.create(date: Date.today, rationale: "some rationale", user_id: @user.id)

			other_user = User.create(first_name: 'Test', last_name: "TestSurname", email: "some@some.com", password: "123456", password_confirmation: "123456")
			post_from_other_user = Post.create(date: Date.today, rationale: "some rationale shouldnt be seen", user_id: other_user.id)
			
			visit posts_path
			expect(page).to_not have_content(/some rationale shouldnt be seen/)
		end
	end

	describe 'new' do
		it 'has a link from the homepage' do
			visit root_path
			click_link("new_post_from_nav") 
			expect(page.status_code).to eq(200)
		end
	end

  describe 'delete' do
    it 'can be deleted' do
      @post = FactoryGirl.create(:post)
      # refactor later
      @post.update(user_id: @user.id)

      visit posts_path

      click_link("delete_post_#{@post.id}_from_index")
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
			click_on "Save"
			expect(page).to have_content("rationale")
		end

		it 'will have a user associated with it' do
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rationale]', with: "User_Association"
			click_on "Save"
			expect(User.last.posts.last.rationale).to eq("User_Association")
		end
	end
	# CHANGE / REFACTOR THIS TEST LATER ON!!!
	describe 'edit' do
	    before do
	      	@edit_user = User.create(first_name: "asdf", last_name: "asdf", email: "asdfasdf@asdf.com", password: "asdfasdf", password_confirmation: "asdfasdf")
	      	login_as(@edit_user, :scope => :user)
	      	@edit_post = Post.create(date: Date.today, rationale: "asdf", user_id: @edit_user.id)
    	end

		it 'can be edited' do 
			visit edit_post_path(@edit_post)
			fill_in 'post[date]', with: Date.today
			fill_in 'post[rationale]', with: "Edited Content"
			click_on "Save"
			expect(page).to have_content("Edited Content")
		end

		it 'cannot be edited by a non-admin or non-authorized user' do 
			logout(:edit_user)
			non_authorized_user = FactoryGirl.create(:non_authorized_user)
			login_as(non_authorized_user, :scope => :user)
			
			visit edit_post_path(@edit_post)

			expect(current_path).to eq(root_path)
		end 
	end
end