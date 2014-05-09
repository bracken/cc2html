require 'thor'

module CC2HTML
  class CLI < Thor
    desc "migrate --format epub COMMON_CARTRIDGE_ZIP EXPORT_NAME", "Migrates Common Cartridge ZIP to an HTML or EPUB representation"
    method_option :format, :default => 'html'
    method_options :format => :string
    method_option :leave_unzipped, :default => false
    method_options :leave_unzipped => :boolean

    def migrate(source, destination)
      converter = CC2HTML::Converter.new source, destination, options
      converter.convert
      puts "#{source} converted to #{converter.cc_file_path}"
    end
  end
end
