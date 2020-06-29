FactoryBot.define do
  factory :user_favorite_cause do
    user
    cause {Organization.causes.keys.sample}
    description { Faker::Lorem.sentence(word_count: rand(4..10)) }
    rank { 1 }
  end
end
