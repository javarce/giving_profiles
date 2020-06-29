FactoryBot.define do
  factory :organization do
    name {Faker::Company.unique.name}
    cause {Organization.causes.keys.sample}
    fb_url {Faker::Internet.url(host: 'facebook.com')}
    location {Faker::Address.state}
  end
end
