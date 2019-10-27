require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

rule /\.rb/ => ".y" do |t|
  sh "racc", "-v", "-o", "#{t.name}", "#{t.source}"
end

task :racc => %w(
  lib/rison/parser.rb
  lib/rison/object/parser.rb
  lib/rison/array/parser.rb
)
