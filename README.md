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

  file :json, '/etc/local/foo.json'

  files :yaml, %w(/etc/local/bar.yml /etc/local/baz.yml)

  namespace :some_service do

    file :json, '/etc/local/app/some_service/config.json'

  end

end

Settled.configuration # your settings
CONFIG                # your settings
configatron           # your settings
```

### File(s)

The file(s) directive allow you to specify one or more files you would like to
read your settings from.

It is important to remember that the files are read and the values merged in the
order you specify them.  Thus, repeating settings will be overwritten by the
most recent file that has them.

Given a JSON config file /etc/local/one.config.

```json
{
  "foo": "bar",
  "bam": {
    "baz": "bang"
  }
}
```

And another JSON config file /etc/local/two.config.

```json
{
  "foo": "not-bar"
}
```
You can read the specify to read the file.

```ruby
Settled::Settings.build do
  ...
  files :json, '/etc/local/one.config', '/etc/local/two.config'
  ...
end

Settled.configuration['foo']        # => 'not-bar'
Settled.configuration['bam']['baz'] # => 'bang'
```

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

### Instance

Instances are the method(s) by which you would like to be able to access your
settings.  There are 2 instance strategies: `[:configatron, :constant]`.  Of
course, you're settings will always be available by Settled::configuration, even
if the instance directive is not specified.

#### Constant

When you specify a constant, Settled creates a constant with the settings instance.

```ruby
Settled::Settings.build do
  ...
  instance :constant, :CONFIG
  ...
end

Settled.configuration # your settings
CONFIG                # your settings
```

#### Configatron

When you specify configatron, Settled extends Kernel with a method configatron
that returns your settings.  This is for compatibility with the
[configatron](https://github.com/markbates/configatron) project in order to 
provide a phased approach to a refactor instaead of a cut-over.

```ruby
Settled::Settings.build do
  ...
  instance :configatron
  ...
end

Settled.configuration # your settings
configatron           # your settings
```
