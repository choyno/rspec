require 'rubygems'
require 'spork'
require 'database_cleaner'

Spork.prefork do
	ENV["RAILS_ENV"] ||= 'test'
	require "rails/application"

	require File.expand_path("../../config/environment", __FILE__)
	require 'rspec/rails'
	require 'rspec/autorun'
	require 'capybara/rspec'

	load "#{Rails.root}/config/routes.rb"


	require File.dirname(__FILE__) + "/../config/environment.rb"
	require File.expand_path("../../config/environment", __FILE__)

	Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

	RSpec.configure do |config|

		Rspec::Application.reload_routes!
		config.include Rails.application.routes.url_helpers
		#config.include MemberMacros, :type => :feature
		config.fixture_path = "#{::Rails.root}/spec/fixtures"


		config.use_transactional_fixtures = false
		config.infer_base_class_for_anonymous_controllers = false

		config.before(:suite) do
			DatabaseCleaner.strategy = :transaction
		end

		config.before(:each) do
			DatabaseCleaner.start
		end

		config.after(:each) do
			DatabaseCleaner.clean
		end

		config.order = "random"
		config.render_views
		config.include FactoryGirl::Syntax::Methods


		config.include Capybara::DSL, :type => :request
		Capybara.asset_host = 'http://localhost:3000'
	end
end


Spork.each_run do
	FactoryGirl.reload
end


