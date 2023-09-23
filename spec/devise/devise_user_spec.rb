## tests to ensure that devise is working properly
require 'rails_helper'

describe 'devise' do
    describe 'sign up' do
        before do
            visit new_user_registration_path
        end

        it 'can be reached successfully' do
            expect(page.status_code).to eq(200)
        end

        it 'new user can be created' do
            fill_in 'user[email]', with: "test_user@test.com"
            fill_in 'user[password]', with: "test_password"
            fill_in 'user[password_confirmation]', with: "test_password"
            click_on "Sign up"
            expect(page).to have_content("Welcome! You have signed up successfully.")
        end

        #TODO: test for invalid email and unhappy paths
        #TODO: test for email validation once mailer is implemented
    end

    describe 'log in' do
        before do
            @user = User.create(email: "test_login@test.com", password: "test_password")
            visit new_user_session_path
        end

        it 'can be reached successfully' do
            expect(page.status_code).to eq(200)
        end

        it 'can log in' do
            fill_in 'user[email]', with: @user.email
            fill_in 'user[password]', with: @user.password
            click_on "Log in"
            expect(page).to have_content("Signed in successfully.")
        end

        it 'cannot log in with invalid credentials' do
            fill_in 'user[email]', with: @user.email
            fill_in 'user[password]', with: "wrong_password"
            click_on "Log in"
            expect(page).to have_content("Invalid Email or password.")
        end

        it 'can logout' do
            fill_in 'user[email]', with: @user.email
            fill_in 'user[password]', with: @user.password
            click_on "Log in"
            click_on "Logout"
            expect(page).to have_content("Signed out successfully.")
        end
    end
end