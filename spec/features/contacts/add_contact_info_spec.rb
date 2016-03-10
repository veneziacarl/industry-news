require 'rails_helper'

feature 'add contact info', %{
  As a interested party
  I want to add my email onto the mailing list
  So that I can get my daily updates
} do

  # Acceptance Criteria:
  # - [x] if I specify a valid email, I am added to the mailing list
  # - [x] if I specify an invalid email, I should see an error
  # - [x] if I am already on the mailing list, I should see an error and not be added again

  let(:contact) { FactoryGirl.create(:contact) }

  scenario 'a new and valid email is entered' do
    visit root_path
    fill_in 'Email', with: 'signup@test.com'
    click_button 'Add Me!'

    expect(page).to have_content('Your email signup@test.com has been successfully added to the list!')
  end

  scenario 'an invalid email is supplied' do
    visit root_path
    fill_in 'Email', with: 'asdf'
    click_button 'Add Me!'

    expect(page).to have_content('You have entered an invalid email address!')
    expect(page).to_not have_content('Your email signup@test.com has been successfully added to the list!')
  end

  scenario 'an already authenticated user cannot re-sign in' do
    visit root_path
    fill_in 'Email', with: contact.email
    click_button 'Add Me!'

    expect(page).to have_content('Your email is already on our mailing list!')
    expect(page).to_not have_content('Your email signup@test.com has been successfully added to the list!')
  end
end
