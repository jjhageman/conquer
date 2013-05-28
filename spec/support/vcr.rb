VCR.configure do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.ignore_localhost         = true
  c.hook_into                :webmock
  c.default_cassette_options = { :record => :new_episodes }
  c.configure_rspec_metadata!
end
