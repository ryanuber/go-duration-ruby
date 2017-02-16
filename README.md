go-duration
===========

`go-duration` is a gem which provides compatibility with Golang's
[time.Duration](https://golang.org/pkg/time/#Duration) type strings.

## Examples

From Golang's time.Duration:

```ruby
d = GoDuration.parse("1m30s")
d.seconds
> 90
```

To Golang's time.Duration:

```ruby
d = GoDuration::Duration.new(90)
d.to_s
> "1m30s"
```
