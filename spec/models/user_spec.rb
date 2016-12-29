require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryGirl.create(:user)
  end
  
  describe "creation" do
  	it "can be created" do
  		expect(@user).to be_valid
  	end
  end

  describe "validations" do

  	it "cannot be created without first_name" do
  		@user.first_name = nil
  		expect(@user).to_not be_valid
  	end

    it "cannot be created without last_name" do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it "cannot be created without phone" do
      @user.phone = nil
      expect(@user).to_not be_valid
    end

    it 'requires the phone to only contain integers' do
      @user.phone = 'mygreatstr'
      expect(@user).to_not be_valid 
    end

    it 'it requires the phone attr to have maximum 14 characters' do 
      @user.phone = "012345678910111"
      expect(@user).to_not be_valid
    end
  end

  describe "custom full name method" do
    it 'has a full name method which combines last and first name' do
      expect(@user.full_name).to eq("TestName, TestSurname")
    end
  end

  describe 'relationship between admins and employees' do 
    it 'allows for admins to be associated with multiple employees' do 
      employee1 = FactoryGirl.create(:user)
      employee2 = FactoryGirl.create(:user)
      admin = FactoryGirl.create(:admin_user)
      Hand.create!(user_id: admin.id, hand_id: employee1.id)
      Hand.create!(user_id: admin.id, hand_id: employee2.id)
      expect(admin.hands.count).to eq(2)
    end
  end
end
