# frozen_string_literal: true

module TurboClone::TestAssertion
  extend ActiveSupport::Concern

  included do
    delegate :dom_id, to: ActionView::RecordIdentifier
  end

  def assert_turbo_stream(action:, target: nil)
    assert_response :ok
    assert_equal Mime[:turbo_stream], response.media_type
    selector = %(turbo-stream[action='#{action}'][target='#{target.respond_to?(:to_key) ? dom_id(target) : target}'])
    assert_select selector, count: 1
  end
end
