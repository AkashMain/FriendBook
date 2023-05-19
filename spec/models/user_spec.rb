require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it "can run tests" do 
    expect(false).to be(false)
  end

  let(:user11){FactoryBot.create(:user)} 
  it "must have name" do
    expect(user11.fname).to eq("Johnny")
  end

  it 'requires a fname to be present' do
    user = User.new(fname: nil)
    expect(user).not_to be_valid
    expect(user.errors[:fname]).to include("can't be blank")
  end

  # context 'validations' do
  #   it 'fname presence' do 
  #     user1= User.new(lname: 'lastname', email: 'okok@gmail.com')
  #     expect(user1.save).to eq(false)
  #   end

  #   it 'email presence' do
  #     user2 = User.new(fname: 'firstname', lname: 'lastname')
  #     expect(user2.save).to eq(false)
  #   end
  # end
  
end
