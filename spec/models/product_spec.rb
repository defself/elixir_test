require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:employee) { create(:user, role: :employee) }
  let(:manager)  { create(:user, role: :management) }
  let(:admin)    { create(:user, role: :admin) }

  before do
    create(:product, updated_by: employee.id, updated_at: 1.minute.ago)
    create(:product, updated_by: manager.id,  updated_at: 1.minute.ago)
    create(:product, updated_by: admin.id,    updated_at: 1.minute.ago)

    create(:product, updated_by: employee.id, updated_at: 1.day.ago)
    create(:product, updated_by: manager.id,  updated_at: 1.day.ago)
    create(:product, updated_by: admin.id,    updated_at: 1.day.ago)

    create(:product, updated_by: employee.id, updated_at: 1.week.ago, title: "The One")
    create(:product, updated_by: manager.id,  updated_at: 1.week.ago)
    create(:product, updated_by: admin.id,    updated_at: 1.week.ago)
  end

  context ".updated_by_employee" do
    it "returns products updated by employees" do
      expect(Product.updated_by_employee.size).to eq 3
    end
  end

  context ".updated_during_last_week" do
    it "returns products updated during last week" do
      expect(Product.updated_during_last_week.size).to eq 3
    end
  end

  context ".updated_by_employee_last_week" do
    it "returns products updated by employees during last week" do
      result = Product.updated_by_employee_last_week

      expect(result.size).to eq 1
      expect(result.first.title).to eq "The One"
    end
  end
end
