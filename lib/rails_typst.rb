# frozen_string_literal: true

require_relative "rails_typst/erb_typst"
require_relative "rails_typst/typst_to_pdf"
require_relative "rails_typst/version"

module RailsTypst
  class Error < StandardError
    attr_reader :source

    def initialize(source:)
      @source = source
      super("Rails_typst processing failed for #{source}. Please check the source.")
    end
  end
end
