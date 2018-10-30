require "rails_helper"

RSpec.describe CajasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/cajas").to route_to("cajas#index")
    end

    it "routes to #new" do
      expect(:get => "/cajas/new").to route_to("cajas#new")
    end

    it "routes to #show" do
      expect(:get => "/cajas/1").to route_to("cajas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cajas/1/edit").to route_to("cajas#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/cajas").to route_to("cajas#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cajas/1").to route_to("cajas#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cajas/1").to route_to("cajas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cajas/1").to route_to("cajas#destroy", :id => "1")
    end
  end
end
