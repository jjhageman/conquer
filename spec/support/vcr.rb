VCR.configure do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.ignore_localhost         = true
  c.hook_into                :webmock
  c.default_cassette_options = { :record => :new_episodes }
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  # so we can use :vcr rather than :vcr => true;
  # in RSpec 3 this will no longer be necessary.
  c.treat_symbols_as_metadata_keys_with_true_values = true
end
