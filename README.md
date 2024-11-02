# PhlexCustomElementGenerator

A way to read a custom elements manifest and generate Phlex components.

## Prerequisites

- Phlex 2.0 - This gem does not support Phlex 1.

## Usage

`gem exec phlex_custom_element_generator`

or

```rb
bundle add phlex_custom_element_generator
bundle exec phlex_custom_element_generator
```

## Commands

### `print_phlex_registrations`

```bash
bundle exec phlex_custom_element_generator print_phlex_registrations [manifest_path]
# Prints a list of all elements from a manifest with kebab-case turned into snake case IE: `sl-alert` -> `sl_alert`
```

### `print_tag_names`

```bash
bundle exec phlex_custom_element_generator print_tag_names [manifest_path]
# Prints a list of all elements from a manifest with original casing
```

### `generate_components`

Generates Phlex components from a given manifest and based upon the manifest path and directory. Currently manifest paths must live locally in your file system.

```bash
bundle exec phlex_custom_element_generator generate_components [manifest_path] [--directory=""] [--namespaces=""]
```

```
`--directory` is the directory to generate to components to IE: `./shoelace`
`--namespaces` is a comma separate module namespace.
```

Using `--namespaces="Views,Shoelace"` will generate the following:

```rb
module Views
  module Shoelace
    class SlAlert
      def initialize(**attributes)
        @attributes = attributes
      end

      def view_template(&)
        sl_alert(**@attributes, &)
      end
    end
  end
end
```

## Roadmap

- [ ] - Support manifests over HTTP
- [ ] - Convenience helper for NPM packages to auto search node_modules
- [ ] - Allow template extensions
- [x] - Add in attributes and default attributes to kwargs for better LSP support.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/phlex_custom_element_generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/phlex_custom_element_generator/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PhlexCustomElementGenerator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/phlex_custom_element_generator/blob/main/CODE_OF_CONDUCT.md).

