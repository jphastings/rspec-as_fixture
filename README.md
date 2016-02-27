# Rspec::AsFixture

[![Build Status](https://travis-ci.org/jphastings/rspec-as_fixture.svg?branch=master)](https://travis-ci.org/jphastings/rspec-as_fixture) [![Test Coverage](https://codeclimate.com/github/jphastings/rspec-as_fixture/badges/coverage.svg)](https://codeclimate.com/github/jphastings/rspec-as_fixture/coverage) [![Code Climate](https://codeclimate.com/github/jphastings/rspec-as_fixture/badges/gpa.svg)](https://codeclimate.com/github/jphastings/rspec-as_fixture)

Load your rspec `let` variables from fixture files defined by your context.

By defining a fixtures yaml file:

```yaml
- title: when the hash defines a paperback book
  book_hash:
    type: paperback
    name: Incidences
    author: Daniil Kharms
```

You can automatically load the fixture keys and make them available for your tests:

```ruby
require 'rspec/as_fixtures'

describe Book do
  describe '::from_hash' do
    subject { Book.from_hash(book_hash) }

    context 'when the hash defines a paperback book', :as_fixture do
      its(:type) { should eq 'paperback' }
    end
  end
end
```

## Installation

Add this line to your application's Gemfile:

```bash
$ gem install rspec-as_fixture
```

## Usage

By defult the fixtures will be sought after in the `spec/fixtures` folder under a filename defined by snake casing the argument of the root `describe` block of the example being run.

In the example above, which would be in `spec/book_spec.rb`, the root block is `describe Book do`, therefore, the glob used to find the file is `spec/fixtures/book.{yml,yaml}`.

Just like `let`s, the inner-most context variables take precedence (see `base_spec.rb` for an example).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/jphastings/rspec-as_fixture/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
