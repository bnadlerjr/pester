# Pester
> "Totally not an hours reminder... I lied." - Robert Smith
Pesters people to enter hours in Harvest.

Given a list of email addresses, it checks Harvest to see that each user has at least 40 hours entered into Harvest for the previous week. If the person doesn't, it sends them a message.

## Usage

```
pester [OPTIONS]

Options:
    -f, --file FILENAME              name of file with employee email addresses
    -h, --help                       show help
```

## Setup
Requires a Ruby interpreter. The version is specified in the `Gemfile`. [Bundler](http://bundler.io/) is used to manage dependencies. Install them via `bundle install`.

In order to connect to Harvest, three environment variables must be set: SUBDOMAIN, USERNAME and PASSWORD. The [Dotenv](https://github.com/bkeepers/dotenv) gem is used to load the environment variables from a `.env` file. See `sample.env` for an example.

## Development

### Tests
Run the tests using the `rake` command. Run `rake -T` to see a list of supported tasks.

Tests are organized into three categories: small, medium and large. A test is assigned to a category based on the following criteria:

| Feature              | Small | Medium         | Large |
| -------------------- | ----- | -------------- | ----- |
| Network access       | No    | localhost only | Yes   |
| Database             | No    | Yes            | Yes   |
| File system access   | No    | Yes            | Yes   |
| Use external systems | No    | Discouraged    | Yes   |
| Multiple threads     | No    | Yes            | Yes   |
| Sleep statements     | No    | Yes            | Yes   |
| System properties    | No    | Yes            | Yes   |

The idea for using these categories and the table above are from this [blog post](http://googletesting.blogspot.com/2010/12/test-sizes.html).
