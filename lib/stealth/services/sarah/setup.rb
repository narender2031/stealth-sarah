# coding: utf-8
# frozen_string_literal: true

require 'stealth/services/sarah/client'

module Stealth
  module Services
    module Sarah
      class Setup

        class << self
          def trigger
            Stealth::Logger.l(topic: "sarah", message: "There is no setup needed!")
          end
        end

      end
    end
  end
end
