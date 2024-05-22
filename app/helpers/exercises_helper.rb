module ExercisesHelper
  def combined_exercises(user)
    Exercise.all.map { |e| [e.name, "Exercise-#{e.id}"] } +
    UserExercise.where(user: user).map { |ue| [ue.name, "UserExercise-#{ue.id}"] }
  end
end
