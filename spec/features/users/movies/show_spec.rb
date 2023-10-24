require "rails_helper"
require "webmock"

RSpec.describe 'User Movie Show Page' do
    before :each do
        @user1 = create(:user)
        visit "/users/#{@user1.id}/movies/550"
        @movie_id = 550
    end

    describe "movie details page content", :vcr do
      it 'has a button to create a viewing party' do 
          expect(page).to have_button("Create New Viewing Party")
          
          click_button("Create New Viewing Party")

          expect(current_path).to eq(new_user_movie_viewing_party_path(@user1, @movie_id))
      end

      it 'has a button to return to the discover page' do 
        expect(page).to have_button("Discover Page")

        click_button("Discover Page")

        expect(current_path).to eq(user_discover_index_path(@user1))
      end

      it 'has movie information' do
        within('#top-movie-title') do 
            expect(page).to have_content("Movie Title: ")
        end

        within('#top-movie-info') do 
            expect(page).to have_content("Vote: ")
            expect(page).to have_content("Runtime: ")
            expect(page).to have_content("Genre: ")
        end

        within('#movie-summary') do 
            expect(page).to have_content("Summary:")
        end

        within('#movie-cast') do 
            expect(page).to have_content("Cast:")
        end

        within('#movie-reviews') do 
            expect(page).to have_content("Reviews:")
            expect(page).to have_content("Content:")
        end
      end
    end
end