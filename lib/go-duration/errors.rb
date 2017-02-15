module GoDuration
  class GoDurationError < RuntimeError; end

  class InvalidUnitError < GoDurationError
    def initialize(unit)
      super <<-EOF.gsub(/^\s*/, "")
      Invalid unit `#{unit}'. Must be one of: #{UNITS.keys.join(", ")}
      EOF
    end
  end
end
