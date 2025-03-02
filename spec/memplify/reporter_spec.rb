# frozen_string_literal: true

RSpec.describe Memplify::Reporter do
  subject { described_class.new(identifier, result) }

  let(:identifier) { "test" }
  let(:result) { instance_double(MemoryProfiler::Results) }
  let(:string_io) { StringIO.new(+"") }
  let(:options) { { detailed_report: true, normalize_paths: true, retained_strings: 0, allocated_strings: 0 } }
  let(:body) do
    {
      identifier: identifier,
      report: Base64.encode64(string_io.string)
    }.to_json
  end
  let(:headers) do
    {
      "Content-Type" => "application/json",
      "Authorization" => "Token token"
    }
  end

  describe "#call" do
    before do
      Memplify.configure do |configuration|
        configuration.access_token = "token"
      end

      allow(StringIO).to receive(:new).and_return(string_io)
      allow(MemoryProfiler::Results).to receive(:new).and_return(result)
      allow(result).to receive(:pretty_print).with(string_io, **options)

      stub_request(:post, "https://memplify.com/api/v1/reports")
        .with(body: body, headers: headers)
        .and_return(status: 201)
    end

    it "reports to memplify" do
      expect(subject.call.code).to eq("201")
    end
  end
end
