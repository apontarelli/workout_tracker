require 'yaml'

begin
  ActiveRecord::Base.connection
  if ActiveRecord::Base.connection.table_exists?('exercises')
    Rails.application.config.after_initialize do
      exercise_file = Rails.root.join('config/exercises.yml')
      exercises = YAML.load_file(exercise_file)['exercises']

      exercises.each do |exercise_data|
        Exercise.find_or_create_by(name: exercise_data['name']) do |exercise|
          exercise.primary_muscle_group = exercise_data['primary_muscle_group']
          exercise.secondary_muscle_groups = exercise_data['secondary_muscle_groups']
          exercise.equipment = exercise_data['equipment']
          exercise.exercise_group = exercise_data['exercise_group']
        end
      end
    end
  end
rescue ActiveRecord::NoDatabaseError, PG::ConnectionBad
  puts 'No database connection found. Skipping load of exercises.'
end
