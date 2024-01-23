# frozen_string_literal: true

class TurboClone::StreamChannel < ActionCable::Channel::Base
  extend TurboClone::Streams::StreamName

  def subscribed
    stream_from params[:signed_stream_name]
  end
end
