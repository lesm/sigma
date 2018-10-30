require "rails_helper"

RSpec.describe "Pages index", type: :system do
  it "Visit root page" do
    #require 'pry'; binding.pry
    visit "http://localhost:3000"
    expect(page).to have_content "Iniciar Sesión"
  end
end
