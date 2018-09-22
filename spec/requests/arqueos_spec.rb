require 'rails_helper'

RSpec.describe "Arqueos", type: :request do
  before :each do
    sign_in FactoryBot.create :cajero
  end

  describe "GET /arqueos" do
    it "list of arqueos" do
      get arqueos_path
      expect(response).to have_http_status(200)
    end
  end
end
