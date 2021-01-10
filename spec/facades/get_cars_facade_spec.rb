require 'rails_helper'

describe CarsFacade do
  it "can return all the current_user's cars" do
    current_user = create(:user)
    result = CarsFacade.get_cars(current_user)
    expect()
  end
end
