# frozen_string_literal: true

module TurboClone::Streams::TurboStreamTagBuilder
  def turbo_stream
    TurboClone::Streams::TagBuilder.new(view_context)
  end
end
