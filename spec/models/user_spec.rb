require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(email: "test@test.com", password: "123456", password_confirmation: "123456", first_name: "Sahil", last_name: "Gadimbayli")
  end
  
  describe "creation" do
  	it "can be created" do
  		expect(@user).to be_valid
  	end

  	it "cannot be created without first_name, last_name" do
  		@user.first_name = nil
  		@user.last_name = nil
  		expect(@user).to_not be_valid
  	end
  end
  describe "custom full name method" do
    it 'has a full name method which combines last and first name' do
      expect(@user.full_name).to eq("Sahil, Gadimbayli")
    end
  end
end
