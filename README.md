# Pester
[![Dependency Status](https://gemnasium.com/bnadlerjr/pester.png)](https://gemnasium.com/bnadlerjr/pester)
[![Code Climate](https://codeclimate.com/github/bnadlerjr/pester.png)](https://codeclimate.com/github/bnadlerjr/pester)

> "Totally not an hours reminder... I lied." - Robert Smith

Pesters people to enter hours in Harvest.

Given a list of email addresses, it checks Harvest to see that each user has at least 40 hours entered into Harvest for the previous week. If the person doesn't, it sends them an SMS message via Twilio.

The list of email addresses and phone numbers are retrieved from a CSV file. See the `test/data/employees.txt` file for a sample of what the file needs to look like.

## Usage

From project root:

```
./bin/pester [OPTIONS]

Options:
    -f, --file FILENAME              name of file with employee email addresses
    -h, --help                       show help
```

## Setup
Requires Ruby. The version is specified in the `Gemfile`. [Bundler](http://bundler.io/) is used to manage dependencies. Install them via `bundle install`.

The [Dotenv](https://github.com/bkeepers/dotenv) gem is used to load the environment variables from an environment file named `prod.env`. The environment file must set the following variables:
* HARVEST_SUBDOMAIN
* HARVEST_USERNAME
* HARVEST_PASSWORD
* TWILIO_ACCOUNT_SID
* TWILIO_AUTH_TOKEN
* FROM_NUMBER

See `sample.env` for an example.

## Development

### Tests
Run the tests using the `rake` command. Run `rake -T` to see a list of supported tasks. Tests get their environment variables from a file named `test.env`. This file needs all of the same variables as the `prod.env` file.

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

*Special note:
Unfortunately, Harvest does not provide a sandbox account for testing. The Harvest tests have a hard-coded email address and hours total for a specific week. If you are adapting this for your own use, you will need to update the email address and hours total to reflect a specific user for your own Harvest instance.*

### Project Architecture
This project uses a [Ports and Adapters](http://alistair.cockburn.us/Hexagonal+architecture) architecture. Domain classes are located in `lib/pester`. Adapters are located in `lib/pester/adapters`.

### Roadmap

Use [GitHub issues](http://github.com/bnadlerjr/pester/issues) for reporting bug and feature requests.

### Patches / Pull Requests
* Fork the project.
* Create a branch.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don’t break it in a future version unintentionally.
* Commit, do not mess with history.
* Send me a pull request.

## License
(The MIT License)

Copyright (c) 2014 Bob Nadler, Jr.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
