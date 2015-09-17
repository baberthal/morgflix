require 'zeus/rails'

class CustomPlan < Zeus::Rails
  def test(*args)
    # require 'simplecov'
    # SimpleCov.start 'rails'
    require 'factory_girl'
    FactoryGirl.reload
    ENV['GUARD_RSPEC_RESULTS_FILE'] ||= 'tmp/guard_rspec_results.txt'
    # _load_all_files
    super
  end

  def sidekiq
    require 'sidekiq/cli'

    begin
      _sidekiq_run
    rescue => e
      raise e if $DEBUG
      STDERR.puts e.message
      STDERR.puts e.backtrace.join("\n")
      exit 1
    end
  end

  private

  def _load_lib_files
    Dir["#{Rails.root}/lib/**/*.rb"].each { |f| load f }
  end

  def _load_app_files
    Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
  end

  def _load_support_files
    Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
  end

  def _load_all_files
    _load_lib_files
    _load_app_files
    _load_support_files
  end

  def _sidekiq_run
    cli = Sidekiq::CLI.instance
    cli.parse
    cli.run
  end
end

Zeus.plan = CustomPlan.new
