require 'rails_helper'

RSpec.describe "Cajeros", type: :request do
  before :each do
    sign_in_admin_with_municipio
  end

  describe "GET /cajeros" do
    it "works! (now write some real specs)" do
      get cajeros_path
      expect(response).to have_http_status(200)
    end
  end
end
