FactoryBot.define do
  factory :template_workout do
    name { "My Template Workout" }
    association :program
    association :user

    after(:build) do |template_workout|
      create_list(:template_exercise, 3, template_workout: template_workout)
    end
  end
end