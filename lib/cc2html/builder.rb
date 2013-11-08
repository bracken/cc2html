module CC2HTML
  class Builder
    def initialize(manifest, dest_dir)
      @dest_dir = dest_dir
      @manifest = manifest
      @items = manifest.organizations.organization.item.items
      lom = manifest.metadata.lom
      @title = lom.general.title.title
      @description = lom.general.description.description if lom.general.description
      if lom.rights && lom.rights.description
        @copy_info = lom.rights.description.description
      end
    end
  end
end