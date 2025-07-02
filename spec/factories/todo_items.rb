# frozen_string_literal: true

FactoryBot.define do
  factory :todo_item do
    title       { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    status      { :to_do }
    due_date    { 2.days.from_now }

    todo_list
  end
end
