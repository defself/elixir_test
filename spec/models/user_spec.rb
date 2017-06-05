require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    create(:user, role: :employee, age: 18)
    create(:user, role: :admin, age: 21)
    create_list(:user, 3, role: :management, age: 33)
  end

  context ".management_average_age" do
    it "returns average age for managers" do
      expect(User.management_average_age).to eq 33
    end
  end

  context ".non_admins" do
    it "returns users with role other than admin" do
      non_admins = User.non_admins

      expect(non_admins.size).to eq 4
      non_admins.each { |user| expect(user).not_to be_admin }
    end
  end

  context ".oldest_users" do
    it "returns top 3 oldest users except admins" do
      oldest_users = User.oldest_users

      expect(oldest_users.size).to eq 3
      oldest_users.each { |user| expect(user.age).to eq 33 }
    end
  end
end
