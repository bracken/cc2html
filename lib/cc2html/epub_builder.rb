module CC2HTML
  class EpubBuilder < Builder
    TEMPLATE_DIR = '../templates/epub/'

    def initialize(manifest, dest_name, zip_file, opts={})
      super(manifest, dest_name)
      @file_name = 'cc_book'
      @content_dir = File.join(@dest_name, 'content')
      @zip_file = zip_file
      @items_with_resource = @manifest.organizations.organization.item.all_items.select{|i|i.resource}
      @leave_in_folder = opts["leave_unzipped"]
    end

    def generate
      FileUtils.mkdir_p(@dest_name)
      create_mimetype_file
      create_meta_inf
      FileUtils.mkdir_p(@content_dir)
      create_opf
      create_nav
      create_chapters
      copy_images
      copy_referenced_html_webresources
      compress_into_epub
    end

    def compress_into_epub
      unless @leave_in_folder
        epub = @dest_name + '.epub'
        FileUtils.rm(epub) if File.exists?(epub)
        Zip::File.open(epub, Zip::File::CREATE) do |zipfile|
          Dir["#{@dest_name}/**/**"].each do |file|
            file_path = file.sub(@dest_name+'/', '')
            zipfile.add(file_path, file)
          end
        end
        FileUtils.rmtree(@dest_name)
      end
    end

    def create_mimetype_file
      File.open(File.join(@dest_name, 'mimetype'), 'w') do |f|
        f << "application/epub+zip\n"
      end
    end

    def create_nav
      template = File.expand_path(TEMPLATE_DIR + 'navigation.html.erb', __FILE__)
      path = File.join(@content_dir, 'navigation.html')

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
        path = File.join(@content_dir, item.identifierref + '.html')
        File.open(path, 'w') do |file|
          erb = ERB.new(File.read(template))
          file.write(erb.result(binding))
        end
      end
    end

    def copy_referenced_html_webresources
      return unless @zip_file.end_with?('zip') || @zip_file.end_with?('imscc')
      Zip::File.open(@zip_file) do |zipfile|
        @items_with_resource.each do |item|
          if item.resource.type == 'webcontent' && item.resource.href && item.resource.href.end_with?('html')
            path = File.join(@content_dir = File.join(@dest_name, 'content'), item.identifierref + '.html')
            File.open(path, 'w') do |file|
              entry = zipfile.get_entry(item.resource.href)
              val = entry.get_input_stream.read
              file << val.gsub('%24IMS_CC_FILEBASE%24', 'web_resources')
              # file << entry.get_input_stream.read
            end
          end
        end
      end
    end

    def copy_images
      return unless @zip_file.end_with?('zip') || @zip_file.end_with?('imscc')
      Zip::File.open(@zip_file) do |zipfile|
        @resources.each do |resource|
          if resource.type == 'webcontent' && resource.href &&
                  resource.href.start_with?('web_resources') &&
                  File.extname(resource.href) =~ /gif|jpg|png/i
            path = File.join(@content_dir, resource.href)
            FileUtils.mkdir_p(File.dirname(path))
            File.open(path, 'w') do |file|
              entry = zipfile.get_entry(resource.href)
              file << entry.get_input_stream.read
            end
          end
        end
      end
    end

    def create_meta_inf
      meta_dir = File.join(@dest_name, 'META-INF')
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
      path = File.join(@content_dir, @file_name + '.opf')

      File.open(path, 'w') do |file|
        erb = ERB.new(File.read(template))
        file.write(erb.result(binding))
      end
    end

  end
end