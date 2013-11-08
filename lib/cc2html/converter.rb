module CC2HTML
  class Converter
    attr_reader :cc_file_path, :dest_dir

    def initialize(cc_file_path, dest_dir, options={})
      @cc_file_path = cc_file_path
      @dest_dir = dest_dir
      @settings = options
    end

    def convert
      manifest = IMS::CC::Manifest.read(@cc_file_path)
      if @settings[:format] == 'html'
        CC2HTML::HtmlBuilder.new(manifest, @dest_dir, @cc_file_path).generate
      elsif @settings[:format] == 'epub'
        CC2HTML::EpubBuilder.new(manifest, @dest_dir, @cc_file_path).generate
      end
    end

  end
end