# frozen_string_literal: true

module TurboClone::Broadcastable
  extend ActiveSupport::Concern

  class_methods do
    def broadcast_target_default
      model_name.plural
    end
  end

  def broadcast_append_to(*streamables, target: broadcast_target_default, **rendering)
    TurboClone::StreamChannel.broadcast_append_to(streamables, target: target,
                                                               **broadcast_rendering_with_defaults(rendering),)
  end

  def broadcast_prepend_to(*streamables, target: broadcast_target_default, **rendering)
    TurboClone::StreamChannel.broadcast_prepend_to(streamables, target: target,
                                                                **broadcast_rendering_with_defaults(rendering),)
  end

  def broadcast_replace_to(*streamables, target: self, **rendering)
    TurboClone::StreamChannel.broadcast_replace_to(streamables, target: target,
                                                                **broadcast_rendering_with_defaults(rendering),)
  end

  def broadcast_remove_to(*streamables, target: self)
    TurboClone::StreamChannel.broadcast_remove_to(streamables, target: target)
  end

  private

  def broadcast_rendering_with_defaults(rendering)
    defaults = { locals: { model_name.element.to_sym => self }, partial: to_partial_path }
    rendering.with_defaults!(defaults)
  end

  def broadcast_target_default
    self.class.broadcast_target_default
  end
end
