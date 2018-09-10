class PagesController < ApplicationController
  layout "pages"
  def index
    redirect_to dashboard_index_path if usuario_signed_in?
  end
end
