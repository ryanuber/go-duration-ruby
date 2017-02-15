module GoDuration
  # The base unit, a single nanosecond.
  NANOSECOND = 1.freeze

  # One microsecond in nanoseconds.
  MICROSECOND = NANOSECOND << 10.freeze

  # One millisecond in nanoseconds.
  MILLISECOND = MICROSECOND << 1.freeze

  # One second in nanoseconds.
  SECOND = MILLISECOND << 1.freeze

  # One minute in nanoseconds.
  MINUTE = 60 * SECOND.freeze

  # One hour in nanoseconds.
  HOUR = 60 * MINUTE.freeze

  # A mapping of Go's unit notations to their nanosecond values. Order is
  # important, it defines how to_s works.
  UNITS = {
    h: HOUR,
    m: MINUTE,
    s: SECOND,
    ms: MILLISECOND,
    µs: MICROSECOND,
    us: MICROSECOND,
    ns: NANOSECOND,
  }.freeze

  # Duration deals with Golang's time.Duration. This type is commonly used
  # in API's and/or CLI's, and is defined in the language itself (there is no
  # formal specifcation or RFC for it). This class can be used to both parse
  # and format duration strings.
  class Duration
    attr_reader :nanoseconds

    # Initializes a new duration instance.
    #
    # @param number [Fixnum]
    # @param unit [Symbol, :s]
    #
    # @return [Duration]
    def initialize(number, unit: :s)
      raise InvalidUnitError, unit unless UNITS[unit]
      @nanoseconds = number * UNITS[unit]
    end

    # Returns the number of microseconds in the duration.
    #
    # @return [Fixnum]
    def microseconds
      nanoseconds / UNITS[:µs]
    end

    # Returns the number of milliseconds in the duration.
    #
    # @return [Fixnum]
    def milliseconds
      nanoseconds / UNITS[:ms]
    end

    # Returns the number of seconds in the duration.
    #
    # @return [Fixnum]
    def seconds
      nanoseconds / UNITS[:s]
    end

    # Returns the number of minutes in the duration.
    #
    # @return [Fixnum]
    def minutes
      nanoseconds / UNITS[:m]
    end

    # Returns the number of hours in the duration.
    #
    # @return [Fixnum]
    def hours
      nanoseconds / UNITS[:h]
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

  module_function

  # Parses a Go time.Duration string.
  #
  # @param duration [String] A Go duration string.
  #
  # @return [Duration]
  def parse(duration)
    ns = 0

    until duration.empty?
      number = duration.slice!(/^[[:digit:]]+/).to_i
      unit = duration.slice!(/^[[:alpha:]]+/).to_sym

      # Check that the units are recognized.
      raise InvalidUnitError, unit unless UNITS[unit]

      # Convert to nanoseconds and add to the total.
      ns += (number * UNITS[unit])
    end

    Duration.new(ns, unit: :ns)
  end
end
