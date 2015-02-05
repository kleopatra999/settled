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

* Environment variables
* JSON configuration file(s)
* YAML configuration file(s)
* Property file(s)
* Database table(s)

In fact, you can mix and match the ways you define setting within a single
application.

To initialize:

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
      foo: 'bar',
    }

    file :property, '/etc/local/development.config'

    env :BAM, 'bam'

  end

end

Settled.configuration # your settings
CONFIG                # your settings
configatron           # your settings
```
