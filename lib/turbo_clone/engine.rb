# frozen_string_literal: true

module TurboClone
  class Engine < ::Rails::Engine
    isolate_namespace TurboClone

    initializer 'turbo_clone.media_type' do
      Mime::Type.register 'text/vnd.turbo-stream.html', :turbo_stream
    end

    initializer 'turbo_clone.helpers' do
      ActiveSupport.on_load(:action_controller_base) do
        helper TurboClone::Engine.helpers
      end
    end
  end
end
