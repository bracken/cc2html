module IMS::CC
  class Attachment
    include HappyMapper

    tag 'attachment'
    attribute :href, String
    attribute :role, String
  end

  class Attachments
    include HappyMapper

    tag 'attachments'
    has_many :attachments, Attachment
  end
end