require 'govuk_tech_docs'
require "lib/govuk_tech_docs/open_api/extension"

GovukTechDocs.configure(self)

activate :open_api
set :layout, 'custom'

page "/adr/*", :layout => "adr"
