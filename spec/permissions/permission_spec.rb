# spec file for testing permissions for admin, superadmin, and user
# using rspec and capybara

# TODO: implement factories for user, admin, superadmin
require 'rails_helper'

describe 'permissions' do
    before do
        @user = User.create(email: "test_user@test.com", password: "test_password")
        @admin = Admin.create(email: "test_admin@test.com", password: "test_password")
        @superadmin = Superadmin.create(email: "test_superadmin@test.com", password: "test_password")
    end

    describe 'user' do
        before do
            login_as(@user)
        end

        describe 'cannot access the admin dashboard' do
            it 'cannot be reached' do
                visit admin_root_path
                expect(current_path).to eq(root_path)
            end
        end

        describe 'cannot access the superadmin dashboard' do
            it 'cannot be reached' do
                visit superadmin_root_path
                expect(current_path).to eq(root_path)
            end
        end
    end

    describe 'admin' do
        before do
            login_as(@admin)
        end

        describe 'can access the admin dashboard' do
            it 'can be reached' do
                visit admin_root_path
                expect(current_path).to eq(admin_root_path)
            end
        end

        describe 'cannot access the superadmin dashboard' do
            it 'cannot be reached' do
                visit superadmin_root_path
                expect(current_path).to eq(root_path)
            end
        end
    end

    describe 'superadmin' do
        before do
            login_as(@superadmin)
        end

        describe 'can access the admin dashboard' do
            it 'can be reached' do
                visit admin_root_path
                expect(current_path).to eq(admin_root_path)
            end
        end

        describe 'can access the superadmin dashboard' do
            it 'can be reached' do
                visit superadmin_root_path
                expect(current_path).to eq(superadmin_root_path)
            end
        end
    end
end
