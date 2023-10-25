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
        expect(page).to have_button('Register')
    end

    it 'create new user button takes user to create page for a new user' do 
        visit(root_path)

        click_button('Register')
        expect(current_path).to eq('/register')
    end

    describe "when I visit root path as a logged in user" do
        before :each do
            @user_1 = User.create!(name: 'Brian', email: 'tacobellrules@email.com', password: 'Murphy123!', password_confirmation: 'Murphy123!')
        end

        it 'shows the login or create account buttons' do
          visit login_path
          fill_in('Email', with: @user_1.email)
          fill_in('Password', with: @user_1.password)
          click_button('Sign In')
    
          visit root_path
    
          expect(page).to_not have_link('Sign In')
          expect(page).to_not have_link('Register')
        end
    
        it 'shows a button to logout' do
          visit login_path
          fill_in('Email', with: @user_1.email)
          fill_in('Password', with: @user_1.password)
          click_button('Sign In')
    
          visit root_path
    
          expect(page).to have_link('Log Out')
        end

        it 'When logout is clicked, it redirects to landing page' do
            visit login_path
            fill_in('Email', with: @user_1.email)
            fill_in('Password', with: @user_1.password)
            click_button('Sign In')
      
            visit root_path
            click_link('Log Out')

            expect(current_path).to eq(root_path)
            expect(page).to have_button('Sign In')
            expect(page).to have_button('Register')
        end

        it 'does not show the user dashboard if not logged in' do
            visit root_path
            visit user_path(@user_1)
      
            expect(current_path).to eq(root_path)
            expect(page).to have_content("Please log in or register")
        end
    end
end