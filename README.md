# TerraspaceHooks

Useful terraspace hook collection.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
    bundle add terraspace_hooks
```

## Usage

```ruby

# inside config/hooks/terraform.rb
before("plan", execute: TerraspaceHooks::TflintValidator)
before("plan", execute: TerraspaceHooks::TfValidator)
after("plan", execute: TerraspaceHooks::InfracostGenerator)

# inside config/hooks/terraspace.rb
after("build", execute: TerraspaceHooks::TfFmtValidator)
after("build", execute: TerraspaceHooks::TfsecValidator)
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
