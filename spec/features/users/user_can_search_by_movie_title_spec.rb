require 'rails_helper'

feature "user can search for movies" do
  scenario "user submits valid movie name", :vcr do
    user = create(:user)
    visit(user_discover_index_path(user))
    fill_in :search, with: 'Up'

    click_button 'Search'

    expect(page.status_code).to eq 200
    expect(page).to have_content("20 Results")
    expect(page).to have_content("Up")
  end
end