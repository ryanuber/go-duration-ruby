require "spec_helper"

module GoTime
  describe "creating a new Duration" do
    context "using a fixnum" do
      it "creates a new Duration" do
        d = Duration.new(Duration::HOUR)
        expect(d.nanoseconds).to equal(Duration::HOUR)
      end
    end

    context "parsing a duration string" do
      it "creates a new Duration" do
        d = Duration.parse("1h")
        expect(d.nanoseconds).to equal(Duration::HOUR)
      end
    end
  end
end
