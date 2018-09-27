require "rails_helper"

RSpec.describe CajerosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/cajeros").to route_to("cajeros#index")
    end

    it "routes to #new" do
      expect(:get => "/cajeros/new").to route_to("cajeros#new")
    end

    it "routes to #show" do
      expect(:get => "/cajeros/1").to route_to("cajeros#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cajeros/1/edit").to route_to("cajeros#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/cajeros").to route_to("cajeros#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cajeros/1").to route_to("cajeros#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cajeros/1").to route_to("cajeros#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cajeros/1").to route_to("cajeros#destroy", :id => "1")
    end
  end
end
