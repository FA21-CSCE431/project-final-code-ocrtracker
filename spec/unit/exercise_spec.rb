#location spec/unit/exercise_spec.rb
require 'rails_helper'

RSpec.describe Exercise, type: :model do

    # Create a subject to test model validity with
    subject do
        FactoryBot.build(:exercise)
    end

    # Ensure that the subject is valid with all fields
    it 'is valid with valid attributes' do
        expect(subject).to be_valid
    end
    
    # Ensure that the subject is not valid without a title
    it 'is not valid without a title' do
        subject.title = nil
        expect(subject).not_to be_valid
    end
    
    # Ensure that the subject is not valid without a description
    it 'is not valid without a description' do
        subject.description = nil
        expect(subject).not_to be_valid
    end
    
    # Ensure that the subject is not valid without a unit name
    it 'is not valid without a unit name' do
        subject.unit_name = nil
        expect(subject).not_to be_valid
    end
    
end