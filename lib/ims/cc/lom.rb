module IMS::CC
module Lom
  NAMESPACE = 'http://ltsc.ieee.org/xsd/imsccv1p3/LOM/manifest'

  class Title
    include HappyMapper
    namespace NAMESPACE

    tag 'title'
    element :title, String, :tag => 'string'
  end

  class Description
    include HappyMapper
    namespace NAMESPACE

    tag 'description'
    element :description, String, :tag => 'string'
  end

  class Keyword
    include HappyMapper
    namespace NAMESPACE

    tag 'keyword'
    element :keyword, String, :tag => 'string'
  end

  class General
    include HappyMapper
    namespace NAMESPACE

    tag 'general'
    has_one :title, Title
    has_one :description, Description
    has_many :keywords, Keyword
  end

  class CopyrightAndOtherRestrictions
    include HappyMapper
    namespace NAMESPACE

    tag 'copyrightAndOtherRestrictions'
    element :value, String
  end

  class Rights
    include HappyMapper
    namespace NAMESPACE

    tag 'rights'
    has_one :copyrightAndOtherRestrictions, CopyrightAndOtherRestrictions
    has_one :description, Description
  end

  class Lom
    include HappyMapper
    namespace NAMESPACE

    tag 'lom'
    has_one :general, General
    has_one :rights, Rights
  end
end
end
