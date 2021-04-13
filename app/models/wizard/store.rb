# frozen_string_literal: true

module Wizard
  class Store
    class InvalidBackingStore < RuntimeError; end

    delegate :keys, :to_h, :to_hash, to: :combined_data

    def initialize(app_data, wizard_data)
      stores = [app_data, wizard_data]
      raise InvalidBackingStore unless stores.all? { |s| s.respond_to?(:[]=) }

      @app_data = app_data
      @wizard_data = wizard_data
    end

    def [](key)
      combined_data[key.to_s]
    end

    def []=(key, value)
      @app_data[key.to_s] = value
    end

    def wizard(key)
      @wizard_data[key.to_s]
    end

    def fetch(*keys, source: :both)
      array_of_keys = Array.wrap(keys).flatten.map(&:to_s)
      Hash[array_of_keys.zip].merge(store(source).slice(*array_of_keys))
    end

    def persist(attributes)
      @app_data.merge!(attributes.stringify_keys)

      true
    end

    def persist_wizard(attributes)
      @wizard_data.merge!(attributes.stringify_keys)

      true
    end

    def purge!
      @app_data.clear
      @wizard_data.clear
    end

  private

    def store(source)
      case source
      when :wizard then @wizard_data
      when :app then @app_data
      else combined_data
      end
    end

    def combined_data
      @wizard_data.merge(@app_data)
    end
  end
end
