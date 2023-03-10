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

# run `tflint` before # terraform plan
before("plan", execute: TerraspaceHooks::TflintValidator)

# run `terraform validate` before terraform plan
before("plan", execute: TerraspaceHooks::TfValidator)

# generate infracost output after terraform plan
after("plan", execute: TerraspaceHooks::InfracostGenerator)
```

```ruby
# inside config/hooks/terraspace.rb

# Run `terraform fmt` after terraspace build
after("build", execute: TerraspaceHooks::TfFmtValidator)

# Run `tfsec` after terraspace build
after("build", execute: TerraspaceHooks::TfsecValidator)
```

To use InfracostGenerator, you need to add this line in
`config/args/terraform.rb`

```ruby
command("plan", args: ["-out tfplan.binary"])
```

Setting this each environment_variable below will skip the correspondent hook.

```bash
SKIP_TERRASPACE_HOOKS_TFSEC_VALIDATOR=1
SKIP_TERRASPACE_HOOKS_TFLINT_VALIDATOR=1
SKIP_TERRASPACE_HOOKS_TF_VALIDATOR=1
SKIP_TERRASPACE_HOOKS_TF_FMT_VALIDATOR=1
SKIP_TERRASPACE_HOOKS_INFRACOST_GENERATOR=1

# or

SKIP_TERRASPACE_HOOKS_ALL=1
# to skip all the hooks
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
