require 'rails_helper'

RSpec.describe 'Dashboard: Discover Movies Page' do
  describe 'When I visit the user discover page' do
    before :each do
      @user1 = create(:user)

      visit user_discover_index_path(@user1)
    end

    it 'has a button to discover top rated movies' do
      expect(page).to have_button('Discover Top Rated Movies')
    end

    it 'has a text field to enter keywords to search by movie title' do 
      expect(page).to have_field("Search")
      expect(page).to have_button("Search")
    end

    it 'when either button is clicked, user is redirected to movie results page', :vcr do 
      fill_in "Search", with: "Up"

      click_button("Search")
      expect(current_path).to eq(user_movies_path(@user1))

      visit user_discover_index_path(@user1)

      click_link("Discover Top Rated Movies")
      expect(current_path).to eq(user_movies_path(@user1))
    end
  end
end