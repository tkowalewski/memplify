# frozen_string_literal: true

module Memplify
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      Memplify.report("#{env["REQUEST_METHOD"]} #{env["REQUEST_PATH"]}") do
        @status, @headers, @body = @app.call(env)
      end

      [@status, @headers, @body]
    end
  end
end
