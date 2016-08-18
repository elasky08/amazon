FactoryGirl.define do
  factory :product do

    sequence(:title) {|n| Faker::Beer.name + n.to_s}
    description      {Faker::Hipster.sentences}
    price            {10 + rand(100)}

  end
end
