require "action_view"

module ActionView
  module Template::Handlers
    class ErbTypst < ERB
      def self.call(template, source = nil)
        source ||= template.source
        new.compile(template, source)
      end

      def compile(template, source)
        erb_source = "<% __in_erb_template = true %>" + source
        out = self.class.erb_implementation.new(erb_source, trim: (self.class.erb_trim_mode == "-")).src
        out + ";RailsTypst::TypstToPdf.generate_pdf(@output_buffer.to_s, @typst_config || {})"
      end
    end
  end

  Template.register_template_handler :erbtypst, Template::Handlers::ErbTypst
end
