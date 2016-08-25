require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do
    it "requires first name must be present" do
      attributes = FactoryGirl.attributes_for :user
      attributes[:first_name] = nil
      user = User.new attributes
      user.valid?
      expect(user.errors).to have_key(:first_name)
    end

    it "requires last name must be present" do
      attributes = FactoryGirl.attributes_for :user
      attributes[:last_name] = nil
      user = User.new attributes
      user.valid?
      expect(user.errors).to have_key(:last_name)
    end

    it "requires email to be unique" do
      user = FactoryGirl.create(:user)
      attributes = FactoryGirl.attributes_for :user
      attributes[:email] = user.email
      user1 = User.new attributes
      user1.valid?
      expect(user1.errors).to have_key(:email)
    end

    it "requires to titleize first name concatenated with last name" do
      u = User.new first_name: "ela", last_name: "tan"
      outcome = u.titleized_name
      expect(outcome).to eq("Ela Tan")
    end

  end
end
