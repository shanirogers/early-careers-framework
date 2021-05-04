# frozen_string_literal: true

class CreateParticipantEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :participant_events, id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string :item_type, null: false
      t.string :event, null: false
      t.string :whodunnit
      t.json :object
      t.json :object_changes
      t.datetime :created_at
      t.uuid :item_id, default: -> { "gen_random_uuid()" }, null: false
      t.index %i[item_type item_id], name: "index_participant_events_on_item_type_and_item_id"
    end
  end
end
