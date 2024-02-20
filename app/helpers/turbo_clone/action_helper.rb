# frozen_string_literal: true

module TurboClone::ActionHelper
  def turbo_stream_action_tag(name, target:, template:)
    template = name == :remove ? '' : "<template>#{template}</template>"
    target = convert_to_turbo_stream_dom_id(target)
    if target
      "<turbo-stream action='#{name}' target='#{target}'>#{template}</turbo-stream>".html_safe # rubocop:disable Rails/OutputSafety
    else
      Raise ArgumentError, 'Target need to be specified'
    end
  end

  def convert_to_turbo_stream_dom_id(target)
    if target.respond_to?(:to_key)
      ActionView::RecordIdentifier.dom_id(target)
    else
      target
    end
  end
end
