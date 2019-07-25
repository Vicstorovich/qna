module CoursesHelper
  def course_type(course)
    type = AdditionalCourse.find_by(additionable_id: course.id)
    type = type.type  unless type.nil?

    if type == "OnlineIntensife"
      t('.type1')
    elsif type == "RecordedCourse"
      t('.type2')
    else type == "RecordedIntensife"
      t('.type3')
    end
  end

  def course_start_date(course)
    date = AdditionalCourse.data_course(course)
    date.course_start_date unless date.nil?
  end

  def course_end_date(course)
    date = AdditionalCourse.data_course(course)
    date.course_end_date unless date.nil?
  end

  def type_course(course)
    AdditionalCourse.data_course(course).type
  end

  def hour_video_course(course)
    hour = AdditionalCourse.data_course(course)
    hour.number_hours_video unless hour.nil?
  end

  def hour_practice_course(course)
    hour = AdditionalCourse.data_course(course)
    hour.number_hours_practice unless hour.nil?
  end
end
