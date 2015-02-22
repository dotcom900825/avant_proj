class ChangeEnrollmentDateToDate < ActiveRecord::Migration
  def change
    change_column :sdtj_demos, :date_of_enrollment, :date
  end
end
