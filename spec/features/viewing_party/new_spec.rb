require "rails_helper"
require "webmock"

RSpec.describe 'Viewing Party New Page' do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @movie_id = 550
    @viewing_party = ViewingParty.create!(duration: 60, party_date: Date.today, start_time: Time.now, movie_id: @movie_id)
  end

  describe "when user visits", :vcr do
    it 'there is forms to fill in for the new viewing party'do 
      visit new_user_movie_viewing_party_path(@user1, @movie_id)
      expect(page).to have_content("Fight Club")

      expect(page).to have_field("Duration")
      expect(page).to have_field("Party date")
      expect(page).to have_field("Start time")
    end

    it 'happy path; when submitted, user is redirected to their path with new viewing party appeared', :vcr do 
      visit new_user_movie_viewing_party_path(@user1, @movie_id)

      fill_in "Duration", with: 200
      fill_in "Party date", with: "2023-10-13"
      fill_in "Start time", with: "08:00"
      check(@user1.id)
      check(@user2.id)
      check(@user3.id)

      click_button("Create")
      expect(current_path).to eq(user_path(@user1))
      expect(page).to have_content("Movie ID: ")
      expect(page).to have_content("Duration: 200")
      expect(page).to have_content("Party Date: 2023-10-13")
      expect(page).to have_content("Start time: 08:00")

      visit user_path(@user2)
      expect(current_path).to eq(user_path(@user2))
      expect(page).to have_content("Movie ID: ")
      expect(page).to have_content("Duration: 200")
      expect(page).to have_content("Party Date: 2023-10-13")
      expect(page).to have_content("Start time: 08:00")

      visit user_path(@user3)
      expect(current_path).to eq(user_path(@user3))
      expect(page).to have_content("Movie ID: ")
      expect(page).to have_content("Duration: 200")
      expect(page).to have_content("Party Date: 2023-10-13")
      expect(page).to have_content("Start time: 08:00")
    end

    it 'sad path; when info is not submitted correctly, flash error message'do
      visit new_user_movie_viewing_party_path(@user1, @movie_id)

      click_button("Create")

      expect(page).to have_content("Please fill in all fields.")
      expect(current_path).to eq(new_user_movie_viewing_party_path(@user1, @movie_id))
    end
  end
end
