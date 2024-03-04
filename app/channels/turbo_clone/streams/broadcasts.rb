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

  def broadcast_append_later_to(*, **)
    broadcast_action_later_to(*, action: :append, **)
  end

  def broadcast_prepend_later_to(*, **)
    broadcast_action_later_to(*, action: :prepend, **)
  end

  def broadcast_replace_later_to(*, **)
    broadcast_action_later_to(*, action: :replace, **)
  end

  def broadcast_action_to(*streamables, action:, target: nil, **rendering)
    broadcast_stream_to(*streamables, content: turbo_stream_action_tag(
      action, target: target, template: rendering.any? ? render_format(:html, **rendering) : nil,),)
  end

  def broadcast_action_later_to(*streamables, action:, target: nil, **rendering)
    TurboClone::Streams::ActionBroadcastJob
      .perform_later(stream_name_from(streamables), action: action, target: target, **rendering)
  end

  def broadcast_stream_to(*streamables, content: nil)
    ActionCable.server.broadcast(stream_name_from(streamables), content)
  end

  private

  def render_format(format, **)
    ApplicationController.render(formats: [format], **)
  end
end
