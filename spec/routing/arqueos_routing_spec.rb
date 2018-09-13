require "rails_helper"

RSpec.describe ArqueosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/arqueos").to route_to("arqueos#index")
    end

    it "routes to #new" do
      expect(:get => "/arqueos/new").to route_to("arqueos#new")
    end

    it "routes to #show" do
      expect(:get => "/arqueos/1").to route_to("arqueos#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/arqueos").to route_to("arqueos#create")
    end
  end
end
