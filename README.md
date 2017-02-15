go-time-ruby
============

`go-time` is a gem which provides compatibility with Golang's
[time.Duration](https://golang.org/pkg/time/#Duration) type strings.

## Examples

From Golang's time.Duration:

```ruby
d = GoTime::Duration.parse("1m30s")
puts d.seconds
> 90
```

To Golang's time.Duration:

```
d = GoTime::Duration.new(90.seconds)
puts d
> 1m30s
```
