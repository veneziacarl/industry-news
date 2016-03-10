require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
  it { should_not have_valid(:email).when(nil, '', 'us', 'us@com', 'us.com') }
end
