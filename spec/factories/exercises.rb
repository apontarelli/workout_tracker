FactoryBot.define do
  factory :exercise do
    sequence(:name) { |n| "Squat #{n}" }
    instructions { "Keep your back straight and bend your knees." }
    primary_muscle_group { "Legs" }
    secondary_muscle_groups { ["Glutes", "Hamstrings"] }
    equipment { "None" }
    exercise_group { "Strength" }
  end
end
