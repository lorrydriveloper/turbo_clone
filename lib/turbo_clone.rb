# frozen_string_literal: true

require 'turbo_clone/version'
require 'turbo_clone/engine'

module TurboClone
  class << self
    attr_writer :signed_stream_verifier_key

    def singned_stream_verifier
      @singned_stream_verifier ||=
        ActiveSupport::MessageVerifier.new(signed_stream_verifier_key, digest: 'SHA256', serializer: JSON)
    end

    def signed_stream_verifier_key
      @signed_stream_verifier_key or raise ArgumentError, 'You need to set a signed_stream_verifier_key'
    end
  end
end
