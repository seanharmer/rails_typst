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
end
