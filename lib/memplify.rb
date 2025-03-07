# frozen_string_literal: true

require "memory_profiler"
require "net/http"
require "base64"
require "json"

require_relative "memplify/version"
require_relative "memplify/configuration"
require_relative "memplify/reporter"
require_relative "memplify/middleware"

module Memplify
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def report(identifier, profile: true, &block)
      return block.call unless profile

      result = MemoryProfiler.report do
        block.call
      end

      Reporter.new(identifier, result).call
    end
  end
end
