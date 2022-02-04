ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
require_rel "test_helpers"

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  # fixtures :all

  class ActiveSupport::TestCase
    include TestSigninHelper
    include TestPasswordHelper
    include ApplicationHelper
    include FactoryBot::Syntax::Methods
  end

  # Add helpers to FactoryBot
  FactoryBot::SyntaxRunner.send :include, TestPasswordHelper

  # Database cleaning
  ActiveRecord::Migration.check_pending!
  DatabaseCleaner.strategy = :truncation
  setup { DatabaseCleaner.start }
  teardown { DatabaseCleaner.clean }
end