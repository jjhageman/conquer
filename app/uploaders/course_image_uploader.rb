class CourseImageUploader < ImageUploader
  process resize_to_fill: [475, 275]

  def default_url
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, 'course.png'].compact.join('_'))
  end
end
