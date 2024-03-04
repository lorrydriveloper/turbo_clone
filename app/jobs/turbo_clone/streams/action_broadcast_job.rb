# frozen_string_literal: true

class TurboClone::Streams::ActionBroadcastJob < ActiveJob::Base
  discard_on ActiveJob::DeserializationError

  def perform(streamable_name, action:, target: nil, **rendering)
    TurboClone::StreamChannel
      .broadcast_action_to(streamable_name, action: action, target: target, **rendering)
  end
end
