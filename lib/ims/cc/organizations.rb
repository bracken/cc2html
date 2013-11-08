module IMS::CC
module Organizations

  class Item
    include HappyMapper
    tag 'item'
    attr_accessor :resource

    attribute :identifier, String
    attribute :identifierref, String
    element :title, String

    has_many :items, Item
  end

  class Organization
    include HappyMapper
    tag 'organization'

    attribute :identifier, String
    attribute :structure, String
    has_one :item, Item
  end

  class Organizations
    include HappyMapper
    tag 'organizations'

    has_one :organization, Organization

    def find_item_by_identifier(id)
      self.organization.item.items.find{|i| i.identifier == id}
    end
  end

end
end