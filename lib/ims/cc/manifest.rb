module IMS::CC
  class Manifest
    include HappyMapper

    attr_accessor :cartridge_zip_file, :manifest_file

    tag 'manifest'
    has_one :metadata, Metadata
    has_one :organizations, IMS::CC::Organizations::Organizations
    has_one :resources, IMS::CC::Resources::Resources

    def self.read(backup_file)
      if File.extname(backup_file) == ".xml"
        manifest = parse File.read(backup_file)
        manifest.manifest_file = backup_file
        manifest.post_process
        manifest
      else
        Zip::File.open(backup_file) do |zipfile|
          entry = zipfile.get_entry("imsmanifest.xml")
          xml = entry.get_input_stream.read
          manifest = parse xml
          manifest.cartridge_zip_file = backup_file
          manifest.post_process
          manifest
        end
      end
    end

    def post_process
      parse_references
      connect_resources_to_org_item
    end

    def connect_resources_to_org_item
      self.organizations.organization.item.items.each do |item|
        next unless item.identifierref
        if res = self.resources.find_by_identifier(item.identifierref)
          item.resource = res
        end
      end
    end

    def parse_references
      if self.cartridge_zip_file
        Zip::File.open(self.cartridge_zip_file) do |zipfile|
          self.resources.resources.each do |res|
            if res.parseable_type? && !res.inline?
              entry = zipfile.get_entry(res.reference_href)
              xml = entry.get_input_stream.read
              res.parse_reference(xml)
            end
          end
        end
      end
    end

  end
end
