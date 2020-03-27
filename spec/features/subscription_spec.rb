require 'rails_helper'

RSpec.describe 'Subscriptions', type: :system, js: true do
  before do
    create(:season)
  end

  def enter_user_details
    fill_in 'subscription_user_attributes_given_name', with: 'Jenny'
    fill_in 'subscription_user_attributes_surname', with: 'Vale'
    fill_in 'subscription_user_attributes_email', with: 'jennyvale@gmail.com'
    fill_in 'subscription_user_attributes_phone', with: '0356223344'
    fill_in 'subscription_user_attributes_password', with: '12345678'
    fill_in 'subscription_user_attributes_password_confirmation', with: '12345678'
  end

  describe 'for weekly pickup on Wednesday' do
    it 'allows the user to subscribe for a veggie box' do
      visit root_path
      click_link 'Sign Up'

      find("label[for='subscription_box_size_standard']").click

      select('Collection from 4/133 North Road, Warragul (Free)', from: 'subscription_delivery')
      select('Wednesday', from: 'subscription_day_of_week')
      select('Weekly', from: 'subscription_frequency')

      enter_user_details

      click_button 'Complete Sign Up'
      expect(page).to have_content 'Thanks Jenny!'
    end
  end

  context 'for fortnightly delivery on Thursday' do
    it 'allows the user to subscribe for a veggie box' do
      visit root_path
      click_link 'Sign Up'

      find("label[for='subscription_box_size_standard']").click

      select('Delivery ($10.00)', from: 'subscription_delivery')
      select('Thursday (Warragul, Drouin, Bunyip and Garfield)', from: 'subscription_day_of_week')
      select('Fortnightly', from: 'subscription_frequency')

      enter_user_details

      fill_in 'subscription_street_address', with: '123 Alfred St'
      fill_in 'subscription_town', with: 'Warragul'
      fill_in 'subscription_postcode', with: '3820'

      click_button 'Complete Sign Up'

      expect(page).to have_content 'Thanks Jenny!'
    end
  end
end
