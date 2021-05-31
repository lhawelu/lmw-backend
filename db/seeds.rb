User.destroy_all
Order.destroy_all
OrderItem.destroy_all
Item.destroy_all
Category.destroy_all

# Creating categories

categories = [
  'Burritos', 
  'Tacos', 
  'Platillos', 
  'Quesadillas', 
  'Nachos & Fries', 
  'Tortas', 
  'Tamales', 
  'Salads', 
  'Pupusas', 
  'Weekend Specials', 
  'Breakfast', 
  'Soups', 
  'Seafood', 
  "Kid's Menu", 
  'Specialties', 
  'Bionicos', 
  'Raspados'
]

categories.each{|category| Category.create(name: category)}

# Creating items

items = [
  {
    name: 'Torta de Bistec Res',
    price: 10.99,
    category: 'Tortas'
  },
  {
    name: 'Super',
    price: 9.99,
    category: 'Burritos'
  },
  {
    name: 'Regular',
    price: 8.49,
    category: 'Burritos'
  },
  {
    name: 'Burrito Guisado',
    price: 8.99,
    category: 'Burritos'
  },
  {
    name: 'Burrito Camaron',
    price: 10.99,
    category: 'Burritos'
  },
  {
    name: 'Veggie Burrito',
    price: 8.49,
    category: 'Burritos'
  },
  {
    name: 'Burrito Bowl',
    price: 9.99,
    category: 'Burritos'
  },
  {
    name: 'Wet Burrito',
    price: 10.49,
    category: 'Burritos'
  },
  {
    name: 'Bean & Cheese Burrito',
    price: 4.59,
    category: 'Burritos'
  },
  {
    name: 'Bean, Cheese & Rice Burrito',
    price: 4.99,
    category: 'Burritos'
  },
  {
    name: 'Fajita Burrito (Chicken or Beef)',
    price: 10.99,
    category: 'Burritos'
  },
  {
    name: 'Soft Taco',
    price: 2.79,
    category: 'Tacos'
  },
  {
    name: 'Crispy Taco',
    price: 3.79,
    category: 'Tacos'
  },
  {
    name: 'Super Taco',
      price: 4.79,
      category: 'Tacos'
  },
  {
    name: 'Taco de Guiso',
    price: 3.99,
    category: 'Tacos'
  },
  {
    name: 'Taco de Pescado',
    price: 4.49,
    category: 'Tacos'
  },
  {
    name: 'Taco de Camaron',
    price: 4.49,
    category: 'Tacos'
  },
  {
    name: 'Taco Plate Soft',
    price: 8.99,
    category: 'Tacos'
  },
  {
    name: 'Taco Plate Crispy',
    price: 10.49,
    category: 'Tacos'
  },
  {
    name: 'Super Nacho Con Carne',
    price: 10.99,
    category: 'Nachos & Fries'
  },
  {
    name: 'Regular Nachos Sin Carne',
    price: 9.99,
    category: 'Nachos & Fries'
  },
  {
    name: 'Carne Asada Fries',
    price: 10.99,
    category: 'Nachos & Fries'
  },
  {
    name: 'Super Quesadilla con Carne',
    price: 10.49,
    category: 'Quesadillas'
  },
  {
    name: 'Regular Quesadilla sin Carne',
    price: 8.99,
    category: 'Quesadillas'
  },
  {
    name: 'Quesabirria',
    price: 3.99,
    category: 'Quesadillas'
  },
  {
    name: 'Steak Ranchero',
    price: 12.49,
    category: 'Platillos'
  },
]

items.each{|item| Item.create!(
  name: item[:name], 
  price: item[:price], 
  description: '', 
  category: Category.find_by(name: item[:category])
  )
}

User.create!(first_name: 'Admin', last_name: 'Admin', username: 'admin', email_address: 'test@test.com', password: 'Fishtank123!')

10.times {
  User.create!(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name, 
    username: Faker::Internet.username,
    email_address: Faker::Internet.email,
    password: 'Fishtank123!'
  )
}

50.times {
  new_order = Order.create!(user: User.all.sample, status: 'completed')
  3.times {
    OrderItem.create!(
      order: new_order,
      item_id: Item.all.sample.id,
      special_instructions: 'Test'
    )
  }
  new_order.subtotal = new_order.items.sum(:price).round(2)
  new_order.tax_amount = (new_order.subtotal * 0.0875).round(2)
  new_order.total_amount = (new_order.subtotal + new_order.tax_amount).round(2)
  new_order.save!
}