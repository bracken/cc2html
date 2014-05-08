module IMS::CC
  class Topic
    include HappyMapper
    #register_namespace('http://www.imsglobal.org/xsd/imsccv1p3/imsdt_v1p3', 'dt3')
    #register_namespace('http://www.imsglobal.org/xsd/imsccv1p1/imsdt_v1p1', 'dt1')
    namespace 'http://www.imsglobal.org/xsd/imsccv1p3/imsdt_v1p3'
    # namespace 'http://www.imsglobal.org/xsd/imsccv1p1/imsdt_v1p1'

    tag 'topic'
    element :title, String
    element :text, String, :attributes => {:texttype => String}
    has_one :attachments, IMS::CC::Attachments
  end
end
