require 'rails_helper'

RSpec.describe 'User Movies Results Page' do
  before :each do
    @user1 = create(:user)
    visit user_movies_path(@user1)
  end

  describe 'Top Rated Movie Results Page', :vcr do
    scenario 'click Discover Top Rated Movies button'do
      visit user_discover_index_path(@user1)
      click_link 'Discover Top Rated Movies'

      expect(current_path).to eq(user_movies_path(@user1))
      expect(page).to have_content('Movie Results')

      expect(page).to have_content("Title")

      within('#movie-details') do 
        expect(page).to have_content("Movie Vote Average")
        expect(page).to have_content("Movie Overview")
      end
    end

    it 'has a Discover Page button to return to the Discover Page' do
      expect(page).to have_button('Discover Page')

      click_button 'Discover Page'

      expect(current_path).to eq(user_discover_index_path(@user1))
    end
  end
end