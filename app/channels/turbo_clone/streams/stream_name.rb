# frozen_string_literal: true

module TurboClone::Streams::StreamName
  def verified_stream_name(signed_stream_name)
    TurboClone.singned_stream_verifier.verify(signed_stream_name)
  end

  def signed_stream_name(*streamables)
    TurboClone.singned_stream_verifier.generate(stream_name_from(streamables))
  end

  def stream_name_from(streamables)
    if streamables.is_a?(Array)
      streamables.map { |streamable| stream_name_from(streamable) }.join(':')
    else
      streamables.then do |streamable|
        streamable.respond_to?(:to_key) ? ActionView::RecordIdentifier.dom_id(streamable) : streamable.to_s
      end
    end
  end
end
