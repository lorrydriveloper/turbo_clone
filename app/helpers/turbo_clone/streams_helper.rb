# frozen_string_literal: true

module TurboClone::StreamsHelper
  def turbo_stream
    TurboClone::Streams::TagBuilder.new(self)
  end

  def turbo_stream_from(*streamables, **attributes)
    attributes[:channel] = attributes[:channel]&.to_s || 'TurboClone::StreamChannel'
    attributes[:'signed-stream-name'] = TurboClone::StreamChannel.stream_name_from(streamables)

    tag.turbo_cable_stream_source(**attributes)
  end
end
