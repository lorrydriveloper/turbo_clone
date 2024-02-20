# frozen_string_literal: true

class TurboClone::Streams::TagBuilder
  include TurboClone::ActionHelper
  attr_reader :view_context

  def initialize(view_context)
    @view_context = view_context
    view_context.formats |= [:html]
  end

  def append(target, content = nil, **, &)
    action(:append, target, content, **, &)
  end

  def prepend(target, content = nil, **, &)
    action(:prepend, target, content, **, &)
  end

  def update(target, content = nil, **, &)
    action(:update, target, content, **, &)
  end

  def replace(target, content = nil, **, &)
    action(:replace, target, content, **, &)
  end

  def remove(target)
    action(:remove, target)
  end

  def action(name, target, content = nil, **, &)
    template = render_template(target, content, **, &) unless name == :remove
    turbo_stream_action_tag(name, target: target, template: template)
  end

  def render_template(target, content = nil, **rendering_options, &)
    if content
      render_content(content)
    elsif block_given?
      render_block(&)
    elsif rendering_options.any?
      render_options(rendering_options)
    else
      render_partial(target)
    end
  end

  def render_content(content)
    if content.respond_to?(:to_partial_path)
      @view_context.render(partial: content, formats: :html)
    else
      content
    end
  end

  def render_block(&)
    view_context.capture(&)
  end

  def render_options(rendering_options)
    view_context.render(**rendering_options, formats: :html)
  end

  def render_partial(target)
    view_context.render(partial: target, formats: :html)
  end
end
