# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Users, type: :model do
  # Create a subject to test model validity with
  subject(:user) do
    FactoryBot.create(:user)
  end

  # Ensure that the subject is valid with all fields
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  # Ensure that the subject is not valid without a submitted datetime
  it 'is valid with no description' do
    user.description = nil
    expect(user).to be_valid
  end
end
