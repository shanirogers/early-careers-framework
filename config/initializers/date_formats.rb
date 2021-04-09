# frozen_string_literal: true

# https://www.gov.uk/guidance/style-guide/a-to-z-of-gov-uk-style#dates
Date::DATE_FORMATS[:govuk]        = "%-d %B %Y" # 2 January 1998
Date::DATE_FORMATS[:govuk_short]  = "%-d %b %Y" # 2 Jan 1998
Date::DATE_FORMATS[:govuk_approx] = "%B %Y"     # January 1998

Date::DATE_FORMATS[:govuk_date_long] = "%A %-d %B"

Time::DATE_FORMATS[:govuk_date] = "%d %m %Y"
Time::DATE_FORMATS[:govuk_date_long] = "%A %-d %B"
Time::DATE_FORMATS[:govuk_time] = "%H:%M"
Time::DATE_FORMATS[:govuk_time_with_period] = "%-I:%M %P"
