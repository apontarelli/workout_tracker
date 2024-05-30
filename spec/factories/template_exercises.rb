FactoryBot.define do
  factory :template_exercise do
    template_workout

    after(:build) do |template_exercise|
      exercise = create(:exercise)
      template_exercise.exercisable_type = 'Exercise'
      template_exercise.exercisable_id = exercise.id
    end

    after(:create) do |template_exercise|
      create_list(:template_set, 3, template_exercise:)
    end
  end
end
