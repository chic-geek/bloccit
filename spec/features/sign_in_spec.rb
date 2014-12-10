# NOTE: A feature spec tests behavior from a user's perspective.

require 'rails_helper'

describe "Sign in flow" do

  include TestFactories

  describe "successful" do
    it "redirects to the topics index" do
      user = authenticated_user
      visit topics_path

      # We give within a class (.) or ID (#) argument, and a block to be executed within
      # the HTML defined by that element. In this case, we've chosen the .user-info div
      # in application.html.erb that surrounds our nav-bar login button.
      # rather than just `click_link 'Sign In'` as there are multiple sign in links on
      # the homepage.
      within '.user-info' do
        click_link 'Sign In'
      end

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within 'form' do
        click_button 'Sign in'
      end

      expect(current_path).to eq topics_path

    end
  end

end
