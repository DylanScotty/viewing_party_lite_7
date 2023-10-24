require 'rails_helper'

RSpec.describe 'User index page' do
    it 'displays title of application' do
        visit(root_path)
        expect(page).to have_content('Viewing Party Lite')
    end

    it 'displays a link to go back to the landing page' do
        visit(root_path)
        expect(page).to have_link('Home', href: root_path)
    end

    it 'displays a button to create a new user' do
        visit(root_path)
        save_and_open_page
        expect(page).to have_button('Register')
    end

    it 'create new user button takes user to create page for a new user' do 
        visit(root_path)

        click_button('Register')
        expect(current_path).to eq('/register')
    end

    it 'displays a list of existing users, that includes links to their show page' do
        @user1 = create(:user)
        @user2 = create(:user)
        @user3 = create(:user)
        visit(root_path)

        expect(page).to have_link(@user1.name)
        expect(page).to have_link(@user2.name)
        expect(page).to have_link(@user3.name)

        click_link(@user1.name)
        expect(current_path).to eq(user_path(@user1))
    end
end