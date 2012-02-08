# encoding: utf-8
require 'carrierwave/processing/mime_types'
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def cache_dir
      "uploads/cache/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Process files as they are uploaded:
   process :resize_to_fit => [600, 600]
   process :convert => 'jpg'
  
   def filename
     super.chomp(File.extname(super)) + '.jpg' unless super.nil?
     @name ||= "#{secure_token}.#{file.extension}" if original_filename.present?
   end
   
  # Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
       "https://radiodepaul.s3.amazonaws.com/img/fallback/" + [version_name,"default.jpg"].compact.join('_')
   end
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  
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

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  protected
  
    def secure_token
      var = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
    end
end
