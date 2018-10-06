require "rails_helper"

RSpec.describe RecibosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/recibos").to route_to("recibos#index")
    end

    it "routes to #show" do
      expect(:get => "/recibos/1").to route_to("recibos#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/recibos").to route_to("recibos#create")
    end

    it "routes to #destroy" do
      expect(:delete => "/recibos/1").to route_to("recibos#destroy", :id => "1")
    end
  end
end
