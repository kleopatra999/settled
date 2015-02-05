# Settled

A framework for defining settings.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'settled'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install settled


## Usage

Settled allows you to define settings in many different ways:

* Environment variables (coming soon)
* JSON configuration file(s)
* YAML configuration file(s)
* Property file(s) (coming soon)
* Database table(s) (coming soon)
* Inline (coming soon)

In fact, you can mix and match the ways you define setting within a single application.

For example:

```ruby
Settled::Settings.build do

  instance :configatron
  instance :constant, :CONFIG

  container Hashie::Mash

  defaults {
    foo: 'bar'
  }

  file :json, '/etc/local/foo.json'
  files :yaml, %w(/etc/local/bar.yml /etc/local/baz.yml)

  env :FOO, 'foo'
  env :FOO_BAR, 'foo.bar'

  namespace :development do

    defaults {
      foo: 'bar'
    }
  
    file :json, '/etc/local/bam.json'

    env :BAM, 'bam'

  end

end

Settled.configuration # your settings
CONFIG                # your settings
configatron           # your settings
```

### Containers

The container refers to the type of the settings instance.  The default is hash.
However, you can customize it with the container directive.  Any class that
accepts a hash to its initializer can be used as a container.

Given a JSON config file.

```json
{
  "foo": "bar",
  "bam": {
    "baz": "bang"
  }
}
```

You could use a [Hashie::Mash](https://github.com/intridea/hashie#mash).

```ruby
Settled::Settings.build do
  ...
  file :json, 'path/to/file'
  container Hashie::Mash
  ...
end

Settled.configuration.class   # => Hashie::Mash
Settled.configuration.bam.baz # => 'bang'
```

You could use a custom class.

```ruby
class DotNotationContainer

  def initialize( settings_hash )
    @settings = settings_hash
  end

  def []( dot_path )
    val = @settings

    dot_path.split( '.' ).each do |part|
      val = val[part]
    end

    val
  end

end

Settled::Settings.build do
  ...
  file :json, 'path/to/file'
  container DotNotationContainer
  ...
end

Settled.configuration.class      # => DotNotationContainer
Settled.configuration['bam.baz'] # => 'bang'
```
