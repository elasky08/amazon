# puts Cowsay.say "Created #{QUESTIONS_TO_CREATE} questions"

cat = 6
cat.times do
  Category.create name: Faker::Commerce.department
end

prod = 1000
prod.times do |i|
  p = Product.create(title: "#{Faker::StarWars.quote}_#{i}",
                  description:  Faker::Hipster.paragraph,
                  price: rand(1..1000), category: Category.all.sample)

  #puts "creating product: #{p.id} - #{p.title}"
  if p.id
    puts "creating product: #{p.id} - #{p.title}"
  else
    puts p.errors.full_messages
  end
end
