require "spec_helper"

module GoDuration
  all_duration = "2h2m2s2ms2µs2ns"
  all_nano = 2 * (
    HOUR +
    MINUTE +
    SECOND +
    MILLISECOND +
    MICROSECOND +
    NANOSECOND
  )

  describe Duration do
    describe "#new" do
      it "creates from seconds by default" do
        d = Duration.new(13)
        expect(d.nanoseconds).to eq(13 * GoDuration::SECOND)
      end

      it "creates with the provided unit" do
        d = Duration.new(13, unit: :ms)
        expect(d.nanoseconds).to eq(13 * GoDuration::MILLISECOND)
      end

      it "raises an error on invalid unit" do
        expect { Duration.new(1, unit: :nope) }
          .to raise_error(GoDuration::InvalidUnitError)
      end
    end

    describe "#to_s" do
      context "when all units are present" do
        it "renders all of the units" do
          expect(Duration.new(all_nano, unit: :ns).to_s)
            .to eq(all_duration)
        end
      end

      context "when a unit overflows" do
        it "reduces into a larger unit" do
          expect(Duration.new(63, unit: :s).to_s).to eq("1m3s")
        end
      end
    end
  end

  describe "#parse" do
    it "parses a time.Duration string" do
      d = GoDuration.parse("1h")
      expect(d.nanoseconds).to eq(HOUR)
    end

    it "recognizes either form of microseconds" do
      a = GoDuration.parse("99us").microseconds
      b = GoDuration.parse("99µs").microseconds
      expect(a).to eq(b)
    end

    context "when multiple units are present" do
      it "converts and adds them up" do
        d = GoDuration.parse("1h43m")
        expect(d.nanoseconds).to eq(HOUR + (43 * MINUTE))
      end

      it "recognizes all of the units" do
        d = GoDuration.parse(all_duration)
        expect(d.nanoseconds).to eq(all_nano)
      end

      it "raises an error if an invalid unit is found" do
        expect { GoDuration.parse("1h2x") }.to raise_error(InvalidUnitError)
      end
    end
  end
end
