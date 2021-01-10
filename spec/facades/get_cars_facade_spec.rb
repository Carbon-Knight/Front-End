require 'rails_helper'

describe CarsFacade do
  it "can return all the current_user's cars" do
    current_user = create(:user)
    result = CarsFacade.get_cars(current_user)

    expect(result).to be_a(Array)
    expect(result.first).to be_a(Car)
  end
end
