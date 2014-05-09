module CC2HTML
  class Builder
    def initialize(manifest, dest_name)
      @dest_name = dest_name
      @manifest = manifest
      @root_items = manifest.organizations.organization.item.items
      @resources = manifest.resources.resources
      lom = manifest.metadata.lom
      @title = lom.general.title.title
      @description = lom.general.description.description if lom.general.description
      if lom.rights && lom.rights.description
        @copy_info = lom.rights.description.description
      end
    end
  end
end