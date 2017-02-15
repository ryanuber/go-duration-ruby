module GoTime
  class GoTimeError < RuntimeError; end

  class InvalidUnitError < GoTimeError
    def initialize(unit)
      super <<-EOF
      Invalid unit `#{unit}'. Must be one of: #{Duration::UNITS.keys.join(", ")}
      EOF
    end
  end
end
