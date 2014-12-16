class ChangeInterviewTimeToEnrollmentTime < ActiveRecord::Migration
  def change
    rename_column :avant_data, :interview_time, :enrollment_time
  end
end
