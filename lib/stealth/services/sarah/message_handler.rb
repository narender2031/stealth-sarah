# coding: utf-8
# frozen_string_literal: true

module Stealth
  module Services
    module Sarah
      class MessageHandler < Stealth::Services::BaseMessageHandler

        attr_reader :service_message, :params, :headers

        def initialize(params:, headers:)
          @params = params
          @headers = headers
        end

        def coordinate
          Stealth::Services::HandleMessageJob.perform_async('sarah', params, {})

          # Relay our acceptance
          [204, 'No Content']
        end

        def process
          @service_message = ServiceMessage.new(service: 'sarah')

          @service_message.sender_id = params['encounter_id']
          @service_message.message = params['value']

          @service_message
        end

      end
    end
  end
end
