class InstructorImageUploader < ImageUploader
  process :resize_to_fill => [53, 53]

  def default_url
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "instructor.png"].compact.join('_'))
  end
end
