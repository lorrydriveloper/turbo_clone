# frozen_string_literal: true

class TurboClone::StreamChannel < ActionCable::Channel::Base
  extend TurboClone::Streams::StreamName
  extend TurboClone::Streams::Broadcasts

  def subscribed
    verified_stream_name = self.class.verified_stream_name(params[:signed_stream_name])
    if verified_stream_name
      stream_from(verified_stream_name)
    else
      reject
    end
  end
end
