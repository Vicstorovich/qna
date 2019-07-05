class LessonImageUploader < BaseUploader
  version :thumb do
    process resize_and_pad: [150, 150]
  end

  version :thumb_2x do
    process resize_and_pad: [450, 450]
  end
end
