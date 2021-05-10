# frozen_string_literal: true

namespace :lead_provider do
  desc "creates API token for lead provider ID parameter"
  task generate_token: :environment do
    begin
      lead_provider = LeadProvider.find(ARGV[1])
    rescue StandardError
      lead_provider = LeadProvider.find_by(name: ARGV[1])
    end
    token = LeadProviderApiToken.create_with_random_token!(lead_provider: lead_provider)
    puts "Generated API token for lead provider (#{lead_provider.id}): #{token}"
  rescue StandardError
    puts "Lead provider for '#{ARGV[1]}' not found"
  ensure
    exit(0)
  end
end
