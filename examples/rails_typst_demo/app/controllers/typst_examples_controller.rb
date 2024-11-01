class TypstExamplesController < ApplicationController
  def index
  end

  def simple
  end

  def simple_erb
    @hello_count = 3
    @title = "Hello, Typst!"
    @fib_count = 10
  end

  def simple_with_files
    # We can specify the supporting files to be included in the typst document.
    # Each entry in the array is a hash with the keys `source` and `destination`.
    @typst_config = {}
    @typst_config[:supporting_files] = [
      { source: Rails.root.join("app", "assets", "images", "logo.svg"), destination: "images/logo.svg" },
    ]
  end
end
