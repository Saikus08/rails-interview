# frozen_string_literal: true

FactoryBot.define do
  factory :todo_list do
    name        { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    status      { :incomplete }
    due_date    { 3.days.from_now }
  end
end
