require 'rails_helper'

RSpec.describe 'New User page' do
  it 'has a form to fill in for a new user' do 
    visit(new_user_path)

    within('.user_creation_form') do 
      expect(page).to have_field("Name")
      expect(page).to have_field("Email")
    end
  end

  it 'when filled in correctly, user is created, redirects to user show page' do 
    visit(new_user_path)

    within('.user_creation_form') do
      fill_in "Name", with: "Joe"
      fill_in "Email", with: "joe@yahoo.com"
      click_button("Register")
    end

    expect(page).to have_current_path(user_path(User.last))
    visit(root_path)
    expect(page).to have_content("Joe")
  end

  it 'when not filled in correctly, user is not created and flash message is there' do 
    visit(new_user_path)

    within('.user_creation_form') do
      fill_in "Name", with: "Joe"
      click_button("Register")
    end

    expect(current_path).to eq('/register')
  end
end