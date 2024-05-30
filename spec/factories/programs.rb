# frozen_string_literal: true

FactoryBot.define do
  factory :program do
    name { 'My Program' }
    description { 'This is a sample program.' }
    user
  end
end
