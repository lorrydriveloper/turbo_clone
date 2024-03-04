# frozen_string_literal: true

require 'turbo_clone/test_assertion'

module TurboClone
  class Engine < ::Rails::Engine
    isolate_namespace TurboClone

    config.turbo = ActiveSupport::OrderedOptions.new

    initializer 'turbo_clone.sigend_stream_verifier_key' do
      TurboClone.signed_stream_verifier_key = config.turbo.signed_stream_verifier_key ||
        Rails.application.key_generator.generate_key('turbo_clone/signed_stream_verifier_key')
    end

    initializer 'turbo_clone.media_type' do
      Mime::Type.register 'text/vnd.turbo-stream.html', :turbo_stream
    end

    initializer 'turbo_clone.helpers' do
      ActiveSupport.on_load(:action_controller_base) do
        include TurboClone::Streams::TurboStreamTagBuilder
        helper TurboClone::Engine.helpers
      end
    end

    initializer 'turbo_clone.turbo_stream_render' do
      ActiveSupport.on_load(:action_controller_base) do
        ActionController::Renderers.add :turbo_stream do |turbo_stream_html, _options|
          turbo_stream_html
        end
      end
    end

    initializer 'turbo_clone.test_assertion' do
      ActiveSupport.on_load(:active_support_test_case) do
        include TurboClone::TestAssertion
      end
    end

    initializer 'turbo_clone.broadcastable' do
      ActiveSupport.on_load(:active_record) do
        include TurboClone::Broadcastable
      end
    end
  end
end
