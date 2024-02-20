# frozen_string_literal: true

module TurboClone::Streams::Broadcasts
  include TurboClone::ActionHelper

  def broadcast_append_to(*, **)
    broadcast_action_to(*, action: :append, **)
  end

  def broadcast_prepend_to(*, **)
    broadcast_action_to(*, action: :prepend, **)
  end

  def broadcast_replace_to(*, **)
    broadcast_action_to(*, action: :replace, **)
  end

  def broadcast_remove_to(*, **)
    broadcast_action_to(*, action: :remove, **)
  end

  private

  def broadcast_action_to(*, action:, target: nil, **rendering)
    broadcast_stream_to(*, content: turbo_stream_action_tag(
      action, target: target, template: rendering.any? ? render_format(:html, **rendering) : nil,),)
  end

  def broadcast_stream_to(*streamables, content: nil)
    ActionCable.server.broadcast(stream_name_from(streamables), content)
  end

  def render_format(format, **)
    ApplicationController.render(formats: [format], **)
  end
end
