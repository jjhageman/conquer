class ChapterImageUploader < ImageUploader
  process :resize_to_fill => [144, 104]

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "chapter.png"].compact.join('_'))
  end
end
