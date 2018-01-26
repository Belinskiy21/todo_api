class ImageUploader < CarrierWave::Uploader::Base

    include Cloudinary::CarrierWave

    version :thumb do
      process resize_to_limit: [250, 250]
    end

    def extension_whitelist
      %w(jpg jpeg gif png)
    end
end
