# frozen_string_literal: true

module Memplify
  class Configuration
    attr_accessor :access_token
    attr_writer :host, :scheme

    def host
      @host || "memplify.com"
    end

    def scheme
      @scheme || "https"
    end
  end
end
