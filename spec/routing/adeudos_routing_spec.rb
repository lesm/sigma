require "rails_helper"

RSpec.describe AdeudosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/adeudos").to route_to("adeudos#index")
    end

    it "routes to #new" do
      expect(:get => "/adeudos/new").to route_to("adeudos#new")
    end

    it "routes to #show" do
      expect(:get => "/adeudos/1").to route_to("adeudos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/adeudos/1/edit").to route_to("adeudos#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/adeudos").to route_to("adeudos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/adeudos/1").to route_to("adeudos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/adeudos/1").to route_to("adeudos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/adeudos/1").to route_to("adeudos#destroy", :id => "1")
    end
  end
end
