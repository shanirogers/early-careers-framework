# frozen_string_literal: true

module Api
  module Payments
    module V1
      class RetentionController < ApplicationController
        def get
          render json: { total_retained: 3 }
        end
      end
    end
  end
end
