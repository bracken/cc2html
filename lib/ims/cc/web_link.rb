module IMS::CC
  class WebLink
    include HappyMapper
    namespace 'http://www.imsglobal.org/xsd/imsccv1p3/imswl_v1p3'
    #namespace 'http://www.imsglobal.org/xsd/imsccv1p1/imsdt_v1p1'

    tag 'webLink'
    element :title, String
    element :url, String, :attributes => {href: String, target: String, windoFeatures: String}
  end
end
