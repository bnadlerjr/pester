require "bundler/setup"
require "test/unit"
require "contest"
require "dotenv"

test_env_filename = File.expand_path("../../test.env", __FILE__)
raise "You need to create a test.env file." unless File.exist?(test_env_filename)
Dotenv.load(test_env_filename)

class Test::Unit::TestCase
  # Syntactic sugar for defining a memoized helper method.
  def self.let(name, &block)
    ivar = "@#{name}"
    self.class_eval do
      define_method(name) do
        if instance_variable_defined?(ivar)
          instance_variable_get(ivar)
        else
          value = self.instance_eval(&block)
          instance_variable_set(ivar, value)
        end
      end
    end
  end
end
