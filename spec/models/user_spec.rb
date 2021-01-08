require 'rails_helper'

describe User, type: :model do

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:uid)}
    it {should validate_uniqueness_of(:uid)}
    it {should validate_presence_of(:token)}
    it {should validate_uniqueness_of(:token)}
  end
end
