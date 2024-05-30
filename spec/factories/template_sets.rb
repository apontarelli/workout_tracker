# frozen_string_literal: true

FactoryBot.define do
  factory :template_set do
    reps { 10 }
    weight { 50 }
    template_exercise
  end
end
