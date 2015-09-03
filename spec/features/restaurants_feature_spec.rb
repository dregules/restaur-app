require 'rails_helper'


feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'no restaurants yet'
      expect(page).to have_link 'add restaurant'
    end
  end
  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('no restaurants yet')
    end
  end
  context 'creating restaurants' do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end
    scenario 'prompts user to fill out the form and then displays the new restaurant' do
      visit '/restaurants'
      click_link 'add restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content('KFC')
      expect(current_path).to eq '/restaurants'
    end
  end
  context 'viewing restaurants' do

    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end
  context 'editing restaurant' do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    let!(:kfc){ Restaurant.create(name:'KFC') }

    scenario 'let a user that created the restaurant, edit that restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'does not let a user that has not created the restaurant, edit that restaurant' do
      click_link 'Sign out'
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test2@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')

      visit '/restaurants'
      click_link 'Edit KFC'
      expect(page).to have_content 'error'
    end 
  end



  context 'deleting restaurants' do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end
    before {Restaurant.create name: 'KFC'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
  context 'an invalid restaurant' do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end

    it 'does not let you submit a name that is too short' do
      visit '/restaurants'
      click_link 'add restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
    it "is not valid unless it has a unique name" do
      Restaurant.create(name: "Moe's Tavern")
      restaurant = Restaurant.new(name: "Moe's Tavern")
      expect(restaurant).to have(1).error_on(:name)
    end
  end
  context 'user not signed in' do
    it 'must be signed to add a restaurant' do
      visit('/')
      click_link 'add restaurant'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
  end
end

