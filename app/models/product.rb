class Product < ApplicationRecord
  scope :updated_by_employee, -> do
    joins(
      <<~SQL
        INNER JOIN users ON users.id = products.updated_by
        AND users.role = #{User.roles[:employee]}
      SQL
    )
  end

  scope :updated_during_last_week, -> do
    last_week = 1.week.ago.to_date..1.day.ago.to_date
    where(updated_at: last_week)
  end

  scope :updated_by_employee_last_week, -> do
    updated_by_employee.updated_during_last_week.order(:updated_at)
  end
end
