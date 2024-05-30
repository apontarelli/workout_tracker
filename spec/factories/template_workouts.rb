FactoryBot.define do
  factory :template_workout do
    name { 'My Template Workout' }
    program
    user

    after(:build) do |template_workout|
      create_list(:template_exercise, 3, template_workout:)
    end
  end
end
