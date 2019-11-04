# frozen_string_literal: true

Rails.application.config.autoload_paths += Dir[Rails.root.join('lib/fast_jsonapi/*.rb')].each { |l| require l }
