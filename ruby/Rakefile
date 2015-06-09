require 'rake/testtask'

# Rake::TestTask.new do |t|    # Default name of task is "test"
#   t.pattern = "test/**/*_test.rb"
# end

task :test do
  $LOAD_PATH.unshift('lib', 'test')
  Dir.glob('./test/**/*_test.rb') { |f| require f }
end

task :default => :test
