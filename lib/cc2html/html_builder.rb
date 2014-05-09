module CC2HTML
  class HtmlBuilder
    TEMPLATE_DIR = '../templates/html/'
    def initialize(manifest, dest_dir, zip_file)
      @manifest = manifest
      @dest_name = dest_dir
      @root_items = manifest.organizations.organization.item.items
    end

    def generate
      FileUtils.mkdir_p(@dest_name)
      template = File.expand_path(TEMPLATE_DIR + 'index.html.erb', __FILE__)
      path = File.join(@dest_name, 'index.html')

      #FileUtils.mkdir_p(File.dirname(path))
      File.open(path, 'w') do |file|
        erb = ERB.new(File.read(template))
        file.write(erb.result(binding))
      end
    end

  end
end