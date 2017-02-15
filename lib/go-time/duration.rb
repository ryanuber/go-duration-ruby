module GoTime
  class Duration
    # One nanosecond
    NANOSECOND = 1.freeze

    # One microsecond
    MICROSECOND = 1000*NANOSECOND.freeze

    # One millisecond
    MILLISECOND = 1000*MICROSECOND.freeze

    # One second
    SECOND = 1000*MILLISECOND.freeze

    # One minute
    MINUTE = 60*SECOND.freeze

    # One hour
    HOUR = 60*MINUTE.freeze

    # A mapping of Go's unit notations to their nanosecond values.
    UNITS = {
      "h" => HOUR,
      "m" => MINUTE,
      "s" => SECOND,
      "ms" => MILLISECOND,
      "µs" => MICROSECOND,
      "us" => MICROSECOND,
      "ns" => NANOSECOND,
    }.freeze

    attr_reader :nanoseconds

    # Initializes a new duration instance.
    #
    # @param ns [Fixnum] Duration in nanoseconds.
    #
    # @return [Duration]
    def initialize(ns)
      @nanoseconds = ns
    end

    # Parses a Go time.Duration string.
    #
    # @param duration [String] A Go duration string.
    #
    # @return [Duration]
    def self.parse(duration)
      ns = 0

      until duration.empty?
        number = duration.slice!(/^[[:digit:]]+/).to_i
        unit = duration.slice!(/^[[:alpha:]]+/)

        # Check that the units are recognized.
        raise InvalidUnitError, unit unless UNITS[unit]

        # Convert to nanoseconds and add to the total.
        ns += (number * UNITS[unit])
      end

      self.new(ns)
    end

    # Returns the number of microseconds in the duration.
    #
    # @return [Fixnum]
    def microseconds
      nanoseconds / MICROSECOND
    end

    # Returns the number of milliseconds in the duration.
    #
    # @return [Fixnum]
    def milliseconds
      nanoseconds / MILLISECOND
    end

    # Returns the number of seconds in the duration.
    #
    # @return [Fixnum]
    def seconds
      nanoseconds / SECOND
    end

    # Returns the number of minutes in the duration.
    #
    # @return [Fixnum]
    def minutes
      nanoseconds / MINUTE
    end

    # Returns the number of hours in the duration.
    #
    # @return [Fixnum]
    def hours
      nanoseconds / HOUR
    end

    # Returns the exact duration in nanoseconds.
    #
    # @return [Fixnum]
    def to_i
      nanoseconds
    end

    # Formats the duration into a Go duration string.
    #
    # @return [String]
    def to_s
      ns = nanoseconds
      fmt = ""

      UNITS.each do |unit, value|
        number, ns = ns.divmod(value)
        fmt << "#{number}#{unit}" if number > 0
      end

      fmt
    end
  end
end
