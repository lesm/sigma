require "rails_helper"

RSpec.describe EmisoresController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/emisores").to route_to("emisores#index")
    end

    it "routes to #new" do
      expect(:get => "/emisores/new").to route_to("emisores#new")
    end

    it "routes to #show" do
      expect(:get => "/emisores/1").to route_to("emisores#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/emisores/1/edit").to route_to("emisores#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/emisores").to route_to("emisores#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/emisores/1").to route_to("emisores#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/emisores/1").to route_to("emisores#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/emisores/1").to route_to("emisores#destroy", :id => "1")
    end
  end
end
