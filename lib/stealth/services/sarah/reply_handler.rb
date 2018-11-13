# coding: utf-8
# frozen_string_literal: true

module Stealth
  module Services
    module Sarah
      class ReplyHandler < Stealth::Services::BaseReplyHandler

        attr_reader :recipient_id, :reply

        def initialize(recipient_id: nil, reply: nil)
          @recipient_id = recipient_id
          @reply = reply
        end

        def text
          response = {
            body: @reply.reply['body'],
            response_helper: @reply.reply['response_helper'] || { type: 'NONE' },
            encounter_id: @recipient_id,
          }
          
          response
        end

        def delay
          { body: nil, response_helper: nil, encounter_id: @recipient_id }
        end

      end
    end
  end
end
