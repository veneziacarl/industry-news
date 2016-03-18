require 'rails_helper'

RSpec.describe Contact, type: :model, vcr: true do
  let(:contact) { FactoryGirl.create(:contact) }
  it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
  it { should_not have_valid(:email).when(nil, '', 'us', 'us@com', 'us.com') }

  skip 'creates an entry on the mailchimp list' do
    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    list_members = gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members.retrieve
    list_members_email = list_members['members'].map { |member| member['email_address'] }

    expect(list_members_email).to_not include(contact.email)

    contact

    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    list_members = gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members.retrieve
    list_members_email = list_members['members'].map { |member| member['email_address'] }

    expect(list_members_email).to include(contact.email)
  end
end
