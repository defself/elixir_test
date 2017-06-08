class User < ApplicationRecord
  authenticates_with_sorcery!
  enum role: {
    employee: 0,
    management: 10,
    admin: 20
  }

  scope :management_average_age, -> { management.average(:age).to_f }
  scope :non_admins,             -> { where.not(role: :admin) }
  scope :oldest_users,           -> { non_admins.order(age: :desc).limit(3) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
