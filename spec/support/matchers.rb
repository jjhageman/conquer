RSpec::Matchers.define :permit do |*args|
  match do |permission|
    permission.allow?(*args).should be_true
  end
end
