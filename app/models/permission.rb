class Permission
  def initialize(user)
    restrict :forums, [:new, :create]
    restrict_none if user && user.admin?
  end

  def allow?(controller, action)
    @restrict_none || !@restricted_actions[[controller.to_s, action.to_s]]
  end

  def restrict_none
    @restrict_none = true
  end

  def restrict(controllers, actions)
    @restricted_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @restricted_actions[[controller.to_s, action.to_s]] = true
      end
    end
  end
end
