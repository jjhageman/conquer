class VideoImageUploader < ImageUploader
  process resize_to_fill: [611, 303]

  def default_url
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, 'video.png'].compact.join('_'))
  end
end
