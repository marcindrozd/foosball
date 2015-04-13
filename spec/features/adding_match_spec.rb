require 'spec_helper'

feature "Adding a match" do
  scenario "user signs in and adds a match" do
    alice = create(:player, first_name: "Alice", last_name: "Avatar",
                    email: "alice@example.com", password: "password", password_confirmation: "password")
    bob = create(:player, first_name: "Bob", last_name: "Robertson")

    visit '/players/sign_in'
    fill_in 'Email', with: 'alice@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content("Sign Out")

    click_link 'Add new match'

    select 'Bob Robertson', from: 'Player2'
    fill_in 'Score player1', with: 10
    fill_in 'Score player2', with: 6

    click_button 'Create Match'

    expect(page).to have_content("Match successfully added!")
    expect(page).to have_content("10 : 6")
    expect(page).to have_content("Alice Avatar")
    expect(page).to have_content("Bob Robertson")
  end
end
