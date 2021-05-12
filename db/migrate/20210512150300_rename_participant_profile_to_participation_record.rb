class RenameParticipantProfileToParticipationRecord < ActiveRecord::Migration[6.1]
  def change
    rename_table :participant_profiles, :participation_records
  end
end
