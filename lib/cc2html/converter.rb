module CC2HTML
  class Converter
    attr_reader :cc_file_path, :dest_dir

    def initialize(cc_file_path, dest_name, options={})
      @cc_file_path = cc_file_path
      @dest_name = dest_name
      @settings = options
    end

    def convert
      manifest = IMS::CC::Manifest.read(@cc_file_path)
      if @settings[:format] == 'html'
        CC2HTML::HtmlBuilder.new(manifest, @dest_name, @cc_file_path).generate
      elsif @settings[:format] == 'epub'
        CC2HTML::EpubBuilder.new(manifest, @dest_name, @cc_file_path, @settings).generate
      end
    end

  end
end