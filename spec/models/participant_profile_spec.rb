# frozen_string_literal: true

require "rails_helper"

RSpec.describe ParticipantProfile, type: :model do
  before :each do
    @object = create(:participant_profile)
  end
  let(:ect_profile) { create(:early_career_teacher_profile) }

  describe "state transitions" do
    it "should have an initial state of assigned" do
      expect(@object).to have_state(:assigned)
    end

    it "should only have expected transitions from the initial state" do
      expect(@object).to allow_event(:join)
      expect(@object).not_to allow_event(:defer, :resume, :withdraw, :complete)
      expect(@object).to transition_from(:assigned).to(:active).on_event(:join)
    end

    it "should only have expected transitions from the active state" do
      @object.join
      expect(@object).to have_state(:active)
      expect(@object).to allow_event(:defer, :withdraw, :complete)
      expect(@object).not_to allow_event(:resume, :join)
      expect(@object).to transition_from(:active).to(:deferred).on_event(:defer)
      expect(@object).to transition_from(:active).to(:withdrawn).on_event(:withdraw)
      expect(@object).to transition_from(:active).to(:completed).on_event(:complete)

    end

    it "should only have expected transitions from the deferred state" do
      @object.join
      @object.defer
      expect(@object).to have_state(:deferred)
      expect(@object).to allow_event(:resume, :withdraw)
      expect(@object).not_to allow_event(:join, :defer, :complete)
      expect(@object).to transition_from(:deferred).to(:active).on_event(:resume)
      expect(@object).to transition_from(:deferred).to(:withdrawn).on_event(:withdraw)
    end

    it "should only have expected transitions from the withdrawn state" do
      @object.join
      @object.withdraw
      expect(@object).to have_state(:withdrawn)
      expect(@object).not_to allow_event(:join, :defer, :resume, :complete)
      expect(@object).to transition_from(:active, :deferred).to(:withdrawn).on_event(:withdraw)
    end


    it "should have no allowed transitions from the completed state" do
      @object.join
      @object.complete
      expect(@object).to have_state(:completed)
      expect(@object).not_to allow_event(:join, :defer, :resume, :complete, :withdraw)
    end
  end
end
