require "fileutils"

module RailsTypst
  class TypstToPdf
    def self.config
      @config ||= {
        baseDir: Rails.root.join(Rails.root, "tmp", "rails_typst"),
        workDir: ->() { "#{Time.now.strftime("%Y%m%d-%H%M%S.%L")}" },
        preserveWorkDir: false
      }
    end

    def self.generate_pdf(typst_source, config = {})
      config = self.config.merge(config)

      # Create the work directory
      dir_name = File.join(config[:baseDir], config[:workDir].call)
      FileUtils.mkdir_p(dir_name)

      # Write the typst source to a file
      typst_file = File.join(dir_name, "input.typst")
      File.open(typst_file, "wb") { |io| io.write(typst_source) }

      # Generate the pdf by running the typst compile command on the input file
      pdf_file = File.join(dir_name, "output.pdf")

      # TODO: Capture the output of the command in case of failure
      command = "typst compile #{typst_file} #{pdf_file}"
      result = system(command)

      if result == true && File.exist?(pdf_file)
        # Return the contents of the pdf file
        pdf_data = File.read(pdf_file)

        # Clean up the work directory unless preserveWorkDir is true
        FileUtils.rm_rf(dir_name) unless config[:preserveWorkDir]

        return pdf_data
      else
        Rails.logger.error "Failed to generate pdf"
        raise RailsTypst::Error.new(source: typst_file)
        return nil
      end
    end
  end
end
