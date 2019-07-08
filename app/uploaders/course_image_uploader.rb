class CourseImageUploader < BaseUploader
  version :thumb do
    process resize_and_pad: [250, 250]
  end

  version :thumb_2x do
    process resize_and_pad: [550, 550]
  end

  version :thumb_mini do
    process resize_and_pad: [50, 50]
  end

end
