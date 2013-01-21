# encoding: utf-8
require 'carrierwave/processing/mime_types'
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  include CarrierWave::RMagick

  storage :fog
  process :set_content_type

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "uploads/cache/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fit => [600, 600]
  process :convert => 'jpg'

  def filename
    super.chomp(File.extname(super)) + '.jpg' unless super.nil?
    @name ||= "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def default_url
    "https://radiodepaul.s3.amazonaws.com/img/fallback/" + [version_name,"default.jpg"].compact.join('_')
  end

  version :square do
    version :large do
      process :resize_to_fill => [600, 600]
    end

    version :medium do
      process :resize_to_fill => [300, 300]
    end

    version :small do
      process :resize_to_fill => [150, 150]
    end

    version :thumb do
      process :resize_to_fill => [50, 50]
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
