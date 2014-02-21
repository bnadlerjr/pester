require "rake/testtask"

task :default => "test:all"

namespace :test do
  test_sizes = %w[small medium large]

  test_sizes.each do |size|
    Rake::TestTask.new(size) do |t|
      t.libs << "test/#{size}"
      t.test_files = Dir["test/#{size}/**/*_test.rb"]
    end
  end

  desc "Run all tests"
  task :all => test_sizes.map { |s| "test:#{s}" }
end
