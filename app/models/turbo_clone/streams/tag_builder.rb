# frozen_string_literal: true

class TurboClone::Streams::TagBuilder
  def initialize(view_context)
    @view_context = view_context
  end

  def replace(target)
    action(:replace, target)
  end

  def action(name, target)
    template = render_template(target)
    turbo_stream_action_tag(name, target: target, template: template)
  end

  private

  def render_template(target)
    @view_context.render(partial: target, formats: :html)
  end

  def turbo_stream_action_tag(name, target:, template:)
    template = "<template>#{template}</template>"
    target = convert_to_turbo_stream_dom_id(target)
    if target
      "<turbo-stream action='#{name}' target='#{target}'>#{template}</turbo-stream>)".html_safe # rubocop:disable Rails/OutputSafety
    else
      Raise ArgumentError, 'Target need to be specified'
    end
  end

  def convert_to_turbo_stream_dom_id(target)
    if target.respond_to?(:to_key)
      @view_context.dom_id(target)
    else
      target
    end
  end
end
