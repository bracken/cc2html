module CC2HTML
  class EpubBuilder < Builder
    TEMPLATE_DIR = '../templates/epub/'

    def initialize(manifest, dest_dir, zip_file=nil)
      super(manifest, dest_dir)
      @file_name = 'cc_book'
      @content_dir = File.join(@dest_dir, 'content')
      @zip_file = zip_file
      @items_with_resource = @items.select{|i|i.resource}
    end

    def generate
      FileUtils.mkdir_p(@dest_dir)
      create_mimetype_file
      create_meta_inf
      FileUtils.mkdir_p(@content_dir)
      create_opf
      create_nav
      create_chapters
      copy_html_webresources
    end

    def create_mimetype_file
      File.open(File.join(@dest_dir, 'mimetype'), 'w') do |f|
        f << "application/epub+zip\n"
      end
    end

    def create_nav
      template = File.expand_path(TEMPLATE_DIR + 'navigation.html.erb', __FILE__)
      path = File.join(@content_dir = File.join(@dest_dir, 'content'), 'navigation.html')

      File.open(path, 'w') do |file|
        erb = ERB.new(File.read(template))
        file.write(erb.result(binding))
      end
    end

    def create_chapters
      template = File.expand_path(TEMPLATE_DIR + 'chapter.html.erb', __FILE__)
      @items_with_resource.each do |item|
        next if item.resource.type == 'webcontent'
        # so stupid... I'll fix later. :)
        @item = item
        path = File.join(@content_dir = File.join(@dest_dir, 'content'), item.identifierref + '.html')
        File.open(path, 'w') do |file|
          erb = ERB.new(File.read(template))
          file.write(erb.result(binding))
        end
      end
    end

    def copy_html_webresources
      return unless @zip_file.end_with?('zip') || @zip_file.end_with?('imscc')
      Zip::File.open(@zip_file) do |zipfile|
        @items_with_resource.each do |item|
          if item.resource.type == 'webcontent' && item.resource.href && item.resource.href.end_with?('html')
            puts item.identifier
            path = File.join(@content_dir = File.join(@dest_dir, 'content'), item.identifierref + '.html')
            File.open(path, 'w') do |file|
              entry = zipfile.get_entry(item.resource.href)
              file << entry.get_input_stream.read
            end
          end
        end
      end
    end

    def create_meta_inf
      meta_dir = File.join(@dest_dir, 'META-INF')
      FileUtils.mkdir_p(meta_dir)
      File.open(File.join(meta_dir, 'container.xml'), 'w') do |f|
        f << <<-XML
<?xml version="1.0"?>
<container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
   <rootfiles>
      <rootfile full-path="content/#{@file_name}.opf" media-type="application/oebps-package+xml"/>
   </rootfiles>
</container>
XML
      end
    end

    def create_opf
      template = File.expand_path(TEMPLATE_DIR + 'descriptor.opf.erb', __FILE__)
      path = File.join(@content_dir = File.join(@dest_dir, 'content'), @file_name + '.opf')

      File.open(path, 'w') do |file|
        erb = ERB.new(File.read(template))
        file.write(erb.result(binding))
      end
    end

  end
end