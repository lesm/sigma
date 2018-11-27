class PagesController < ApplicationController
  layout "pages"

  def index
    if usuario_signed_in?
      flash.keep(:notice)
      redirect_to dashboard_path
    end
  end
end
