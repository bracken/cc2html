module IMS::CC
module Resources

  class File
    include HappyMapper
    tag 'file'

    attribute :href, String
  end

  class Dependency
    include HappyMapper
    tag 'dependency'

    attribute :identifierref, String
  end

  class Resource
    PARSABLE_TYPES = /imsdt|imswl|assignment/
    include HappyMapper
    tag 'resource'

    attribute :identifier, String
    attribute :type, String
    attribute :href, String
    attribute :intendeduse, String

    has_many :files, File
    has_many :dependencies, Dependency
    has_one :topic, IMS::CC::Topic
    has_one :web_link, IMS::CC::WebLink
    has_one :assignment, IMS::CC::Assignment::Assignment

    def inline?
      !!(self.files.count == 0 && (self.topic || self.web_link))
    end

    def parseable_type?
      !!(self.type =~ PARSABLE_TYPES)
    end

    def reference_href
      return if inline?
      self.files.first.href
    end

    def parse_reference(xml)
      case self.type
        when /imsdt/
          self.topic = IMS::CC::Topic.parse(xml)
        when /imswl/
          self.web_link = IMS::CC::WebLink.parse(xml)
        when /assignment/
          self.assignment = IMS::CC::Assignment::Assignment.parse(xml)
      end
    end
  end

  class Resources
    include HappyMapper
    tag 'resources'

    has_many :resources, Resource

    def find_by_identifier(id)
      resources.find {|r|r.identifier == id}
    end
  end

end
end
