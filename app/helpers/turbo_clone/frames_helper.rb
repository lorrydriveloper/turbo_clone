# frozen_string_literal: true

module TurboClone::FramesHelper
  def turbo_frame_tag(resource, &)
    id = resource.respond_to?(:to_key) ? dom_id(resource) : resource
    tag.turbo_frame(id: id, &)
  end
end
