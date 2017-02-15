class GoDuration

  NANOSECOND=1.freeze
  MICROSECOND=1000*NANOSECOND.freeze
  MILLISECOND=1000*MICROSECOND.freeze
  SECOND=1000*MILLISECOND.freeze
  MINUTE=60*SECOND.freeze
  HOUR=60*MINUTE.freeze

  UNITS={
    'h' => HOUR,
    'm' => MINUTE,
    's' => SECOND,
    'ms' => MILLISECOND,
    'µs' => MICROSECOND,
    'us' => MICROSECOND,
    'ns' => NANOSECOND,
  }.freeze

  attr_reader :nanoseconds

  def initialize(v)
    @nanoseconds = parse(v)
  end

  def microseconds
    nanoseconds / MICROSECOND
  end

  def milliseconds
    nanoseconds / MILLISECOND
  end

  def seconds
    nanoseconds / SECOND
  end

  def minutes
    nanoseconds / MINUTE
  end

  def hours
    nanoseconds / HOUR
  end

  def format
    ns = nanoseconds
    fmt = ""

    UNITS.each do |unit, value|
      number, ns = ns.divmod(value)
      fmt << "#{number}#{unit}" if number > 0
    end

    fmt
  end

  private

  def parse(v)
    ns = 0

    while v.length > 0
      number = v.slice!(/[[:digit:]]+/).to_i
      unit = v.slice!(/[[:alpha:]]+/)

      raise "Invalid unit '#{unit}'" unless UNITS[unit]
      ns += (number * UNITS[unit])
    end

    ns
  end
end
