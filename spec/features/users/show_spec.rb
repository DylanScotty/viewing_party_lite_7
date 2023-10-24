require 'rails_helper'

RSpec.describe 'User Dashboard Page' do
  before :each do 
    @user1 = create(:user)
    @viewing_party1 = ViewingParty.create!(duration: 3, party_date: Date.today, start_time: Time.now, movie_id: 550)
    PartyGuest.create!(user_id: @user1.id, viewing_party_id: @viewing_party1.id, host: true)
    @viewing_party2 = ViewingParty.create!(duration: 4, party_date: Date.today, start_time: Time.now, movie_id: 550)
    @viewing_party3 = ViewingParty.create!(duration: 6, party_date: Date.today, start_time: Time.now, movie_id: 550)
  end

  it 'page has user name on top, has a button to Discover Movies, a section that lists viewing parties' do 
    visit(user_path(@user1))

    expect(page).to have_content("#{@user1.name}'s Dashboard")
    expect(page).to have_button("Discover Movies")
    expect(page).to have_content("Viewing Parties")

    within("#viewing_party-#{@viewing_party1.id}") do
      expect(page).to have_link("550")
      expect(page).to have_content(@viewing_party1.duration)
      expect(page).to have_content(@viewing_party1.party_date)
      expect(page).to have_content(@viewing_party1.start_time.strftime('%H:%M'))
    end
  end

  it 'has a button to discover movies that when clicked, takes user to user discover page' do 
    visit(user_path(@user1))

    click_link("Discover Movies")
    expect(current_path).to eq(user_discover_index_path(@user1))
  end
end