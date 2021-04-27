# frozen_string_literal: true

profile = LeadProviderProfile.last
lead_provider = profile.lead_provider
delivery_partner = FactoryBot.create(:delivery_partner, name: "Delivery Partner 1")
ProviderRelationship.create!(delivery_partner: delivery_partner, lead_provider: lead_provider, cohort: Cohort.current)
