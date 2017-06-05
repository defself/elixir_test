class Seed
  def create_all
    clean_up!
    create_users
    create_products
    puts 'Seeding complete'
  end

  def create_products
    50.times do
      Product.create(
        title: Faker::Commerce.product_name,
        articul: Faker::Number.hexadecimal(12),
        price: Faker::Commerce.price,
        sale: sample_sale,
        updated_by: sample_user_id
      )
    end
  end

  def create_users
    create_demo_user

    { management: 15, employee: 100, admin: 3 }.each do |role, size|
      size.times { create_user(role) }
    end
  end

  def create_user(role)
    name = Faker::Name.first_name
    User.create(
      role: role,
      email: Faker::Internet.email(name),
      first_name: name,
      last_name: Faker::Name.last_name,
      age: sample_age(role),
      password: 'demopass'
    )
  end

  private

  def clean_up!
    [User, Product].each(&:destroy_all)
  end

  def create_demo_user
    User.create(
      role: 'admin',
      email: 'demo@example.com',
      first_name: 'Demo',
      last_name: 'Man',
      age: sample_age('admin'),
      password: 'demopass'
    )
  end

  def sample_age(role)
    role.intern == :management ? rand(35..70) : rand(18..45)
  end

  def sample_sale
    chance ? rand(0.0..0.3).round(2) : 0
  end

  def sample_user_id
    chance ? User.ids.sample : nil
  end

  def chance
    rand(2).odd?
  end
end

Seed.new.create_all
