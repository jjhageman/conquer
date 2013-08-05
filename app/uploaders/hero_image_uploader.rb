class HeroImageUploader < ImageUploader
  process :resize_to_fill => [1600, 363]

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "hero.png"].compact.join('_'))
  end
end
