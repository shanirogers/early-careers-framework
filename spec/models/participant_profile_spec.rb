# frozen_string_literal: true

require "rails_helper"

RSpec.describe ParticipantProfile, type: :model do
  before :each do
    @participant_profile = create(:participant_profile)
  end
  let(:ect_profile) { create(:early_career_teacher_profile) }

  describe "state transitions" do
    it "should have an initial state of assigned" do
      expect(@participant_profile).to have_state(:assigned)
    end

    it "should only have expected transitions from the initial state" do
      expect(@participant_profile).to allow_event(:join)
      expect(@participant_profile).not_to allow_event(:defer, :resume, :withdraw, :complete)
      expect(@participant_profile).to transition_from(:assigned).to(:active).on_event(:join)
    end

    it "should only have expected transitions from the active state" do
      @participant_profile.join
      expect(@participant_profile).to have_state(:active)
      expect(@participant_profile).to allow_event(:defer, :withdraw, :complete)
      expect(@participant_profile).not_to allow_event(:resume, :join)
      expect(@participant_profile).to transition_from(:active).to(:deferred).on_event(:defer)
      expect(@participant_profile).to transition_from(:active).to(:withdrawn).on_event(:withdraw)
      expect(@participant_profile).to transition_from(:active).to(:completed).on_event(:complete)
    end

    it "should only have expected transitions from the deferred state" do
      @participant_profile.join
      @participant_profile.defer
      expect(@participant_profile).to have_state(:deferred)
      expect(@participant_profile).to allow_event(:resume, :withdraw)
      expect(@participant_profile).not_to allow_event(:join, :defer, :complete)
      expect(@participant_profile).to transition_from(:deferred).to(:active).on_event(:resume)
      expect(@participant_profile).to transition_from(:deferred).to(:withdrawn).on_event(:withdraw)
    end

    it "should only have expected transitions from the withdrawn state" do
      @participant_profile.join
      @participant_profile.withdraw
      expect(@participant_profile).to have_state(:withdrawn)
      expect(@participant_profile).not_to allow_event(:join, :defer, :resume, :complete)
      expect(@participant_profile).to transition_from(:active, :deferred).to(:withdrawn).on_event(:withdraw)
    end

    it "should have no allowed transitions from the completed state" do
      @participant_profile.join
      @participant_profile.complete
      expect(@participant_profile).to have_state(:completed)
      expect(@participant_profile).not_to allow_event(:join, :defer, :resume, :complete, :withdraw)
    end
  end
end
