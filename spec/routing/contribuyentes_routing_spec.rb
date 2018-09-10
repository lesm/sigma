require "rails_helper"

RSpec.describe ContribuyentesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/contribuyentes").to route_to("contribuyentes#index")
    end

    it "routes to #new" do
      expect(:get => "/contribuyentes/new").to route_to("contribuyentes#new")
    end

    it "routes to #show" do
      expect(:get => "/contribuyentes/1").to route_to("contribuyentes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/contribuyentes/1/edit").to route_to("contribuyentes#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/contribuyentes").to route_to("contribuyentes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/contribuyentes/1").to route_to("contribuyentes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/contribuyentes/1").to route_to("contribuyentes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/contribuyentes/1").to route_to("contribuyentes#destroy", :id => "1")
    end
  end
end
