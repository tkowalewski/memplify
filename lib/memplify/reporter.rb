# frozen_string_literal: true

module Memplify
  class Reporter
    def initialize(identifier, report)
      @identifier = identifier
      @report = report
    end

    def call
      @report.pretty_print(string_io, **options)

      Net::HTTP.post(uri, body.to_json, headers)
    end

    private

    def options
      {
        detailed_report: true,
        normalize_paths: true,
        retained_strings: 0,
        allocated_strings: 0
      }
    end

    def uri
      URI("#{scheme}://#{host}/api/v1/reports")
    end

    def scheme
      Memplify.configuration.scheme
    end

    def host
      Memplify.configuration.host
    end

    def body
      {
        identifier: @identifier,
        report: Base64.encode64(string_io.string)
      }
    end

    def string_io
      @string_io ||= StringIO.new(+"")
    end

    def headers
      {
        "Content-Type" => "application/json",
        "Authorization" => "Token #{access_token}"
      }
    end

    def access_token
      Memplify.configuration.access_token
    end
  end
end
