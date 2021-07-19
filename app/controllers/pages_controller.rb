class PagesController < ApplicationController
  include ReportGenerator

  def home
    handle_input_file()
  end
end