class PagesController < ApplicationController
  def about
    @page = Page.find_by(page_type: "about")
  end

  def contact
    @page = Page.find_by(page_type: "contact")
  end
end
