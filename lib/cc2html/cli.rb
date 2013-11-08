require 'thor'

module CC2HTML
  class CLI < Thor
    desc "migrate COMMON_CARTRIDGE_ZIP EXPORT_DIR", "Migrates Common Cartridge ZIP to an HTML representation"
    method_option :format, :default => 'html'
    method_options :format => :string

    def migrate(source, destination)
      converter = CC2HTML::Converter.new source, destination, options
      converter.convert
      puts "#{source} converted to #{converter.cc_file_path}"
    end
  end
end
