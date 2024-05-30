FactoryBot.define do
  factory :template_set do
    reps { 10 }
    weight { 50 }
    association :template_exercise
  end
end