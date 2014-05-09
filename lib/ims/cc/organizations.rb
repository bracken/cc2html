module IMS::CC
module Organizations

  class Item
    include HappyMapper
    tag 'item'
    attr_accessor :resource

    attribute :identifier, String
    attribute :identifierref, String
    element :title, String

    # This is so that it only select parent items of itself,
    # otherwise HappyMapper does .// instead of ./
    # can this reference its own namespace somehow?
    has_many :items, Item, :xpath => "./#{HappyMapper::DEFAULT_NS}:item"

    def find_by_identifier(id)
      if id == identifier
        self
      else
        items.each do |i|
          if item = i.find_by_identifier(id)
            return item
          end
        end
      end
    end

    def attach_resources(resources)
      @resource = resources.find_by_identifier(identifierref) if identifierref
      items.each { |i| i.attach_resources(resources) }
    end

    def all_items(res=[])
      res << self
      items.each{|i|i.all_items(res)}
      res
    end
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
      organization.item.find_by_identifier(id)
    end

    def attach_resources_to_items(resources)
      organization.item.attach_resources(resources)
    end
  end

end
end