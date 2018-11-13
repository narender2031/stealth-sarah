# coding: utf-8
# frozen_string_literal: true

require 'stealth/services/sarah/message_handler'
require 'stealth/services/sarah/reply_handler'
require 'stealth/services/sarah/setup'

require 'stealth/services/sarah/sarah_graph'

module Stealth
  module Services
    module Sarah
      class Client < Stealth::Services::BaseClient
        include SarahGraph

        attr_reader :body, :response_helper, :encounter_id

        def initialize(reply:)
          @body = reply[:body]
          @response_helper = reply[:response_helper]
          @encounter_id = reply[:encounter_id]
        end

        def transmit
          # Don't transmit anything for delays
          return true if body.blank? || body.nil?

          response = SarahGraph::Client.query(
            SarahGraph::SendStealthResponse,
            variables: {
              encounter_id: encounter_id.to_i,
              body: body || '',
              responseHelper: format_response_helper(response_helper)
            }
          )

          Stealth::Logger.l(topic: 'sarah', message: "Transmitting. Reply: #{body} with #{response_helper} to #{encounter_id}. Sarah response: #{response.to_h}")
        end

        private

        def format_response_helper(reply)
          {
            type: reply['type'] || '',
            promptHint: reply['prompt_hint'] || '',
            options: format_options(reply['type'], reply['options']),
          }
        end
        
        def format_options(reply_type, options)
          case reply_type
          when 'TEXT'
          when 'EMAIL'
          when 'NUMBER'
          when 'DATE'
          when 'DATE_BIRTHDAY'
            options
          when 'SELECT'
          when 'BOOLEAN'
            format_options_array(options)
          # when 'NONE'
          # when 'TYPING'
          else
            nil
          end
        end

        def format_options_array(options)
          array = []
          if options
            options.each do |o|
              array << {
                label: o['label'] || '',
                description: o['description'] || '',
                value: o['value'].to_s || ''
              }
            end
          end
          array
        end
      end
    end
  end
end
