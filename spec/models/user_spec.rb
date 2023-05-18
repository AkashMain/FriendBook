require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it "can run tests" do 
    expect(false).to be(false)
  end

  it "must have name" do
    user11= FactoryBot.create(:user) 
    expect(user11.fname).to eq("John")
  end

end
