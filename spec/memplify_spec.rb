# frozen_string_literal: true

RSpec.describe Memplify do
  it "has a version number" do
    expect(Memplify::VERSION).not_to be nil
  end

  describe ".report" do
    subject do
      Memplify.report("test", profile: profile) do
        1 + 1
      end
    end

    context "when we should profile" do
      let(:profile) { true }

      before do
        stub_request(:post, "https://memplify.com/api/v1/reports").and_return(status: 201)
      end

      it "call memory_profiler and reporter" do
        expect(MemoryProfiler).to receive(:report).and_call_original
        expect(Memplify::Reporter).to receive(:new).and_call_original

        subject
      end
    end

    context "when we shouldn't profile" do
      let(:profile) { false }

      it "doesn't call memory_profiler and reporter" do
        expect(MemoryProfiler).to_not receive(:report)
        expect(Memplify::Reporter).to_not receive(:new)

        subject
      end
    end
  end
end
