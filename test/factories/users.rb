FactoryBot.define do
  factory :user do
    name {"とっぽぎ"}
    gender {"male"}
    email {Faker::Internet.free_email}
    password {'aaBB1029'}
    password_confirmation {password}
    birthday {"2000-01-01"}
    is_active {true}
  end
end