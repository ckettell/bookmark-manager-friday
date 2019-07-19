
feature "user creates bookmark" do
  scenario "user wants to store a favorite website" do
    visit('/')
    click_button('Create Bookmark')
    fill_in 'url', with: 'https://www.cockandballs.com'
    fill_in 'title', with: 'Chicken Tennis'
    click_button('Add Bookmark')
    # click_button('View Bookmarks')

    expect(page).to have_link('Chicken Tennis', href: 'https://www.cockandballs.com')
  end

  scenario 'the bookmark must be a valid URL' do
    visit('/')
    click_button('Create Bookmark')
    fill_in 'url', with: 'not a real bookmark'
    click_button('Add Bookmark')

    expect(page).not_to have_content "not a real bookmark"
    expect(page).to have_content 'You must submit a valid URL'
  end
end
