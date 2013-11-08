module IMS::CC
module Assignment

  class Format
    include HappyMapper

    tag 'format'
    attribute :type, String
  end

  class SubmissionFormats
    include HappyMapper

    tag 'submission_formats'
    has_many :formats, Format
  end

  class Assignment
    include HappyMapper
    namespace 'http://www.imsglobal.org/xsd/imscc_extensions/assignment'

    tag 'assignment'
    element :title, String
    element :text, String, :attributes => {href: String, texttype: String}
    element :instructor_text, String, :attributes => {href: String, texttype: String}
    element :gradable, Boolean
    has_one :submission_formats, SubmissionFormats
    has_one :attachments, IMS::CC::Attachments

    after_parse do |assignment|
      if assignment.submission_formats
        assignment.submission_formats = assignment.submission_formats.formats.map{|f|f.type}
      end
    end
  end
end
end
