require 'rails_helper'

RSpec.describe Comment, type: :model do
    
    let(:user) {FactoryBot.create(:user)}
    let(:post) { FactoryBot.create(:post, user: user)}
    # Associations
    it {should belong_to(:post)}
    it {should belong_to(:user)}
    it {should have_many(:likes).dependent(:destroy)}
  
    # Validations
    it {should validate_presence_of(:content)}
  
    # Custom Validation
    describe "cant comment own post" do 
        # let(:user) {FactoryBot.create(:user, email: "new@gmail.com")}
        # let(:post) { FactoryBot.create(:post, user: user)}
        let(:comment) { FactoryBot.build(:comment, user: user, post: post) }

        context "when commenting own post" do 
            it "add an error to user_id" do 
                comment.valid?
                expect(comment.errors[:user_id]).to include('User can not comment on his own post')
            end
        end

        context "when commenting on another user's post" do
            let(:other_user) { FactoryBot.create(:user, email: "brandnew@gmail.com") }
            let(:other_post) { FactoryBot.create(:post, body: "LOLOL", user: other_user) }
            let(:comment) { FactoryBot.build(:comment, user: user, post: other_post) }
      
            it "does not add an error to user_id" do
              comment.valid?
              expect(comment.errors[:user_id]).to be_empty
            end
        end
    end

    # Scopes
    describe "default scope" do
      it "orders comments by creation date in ascending order" do
        user1 = FactoryBot.create(:user, email: 'OKOK@mail.com')
        # post = FactoryBot.create(:post, user: user)
        comment1 = FactoryBot.create(:comment, user: user1, post: post, created_at: 2.days.ago)
        comment2 = FactoryBot.create(:comment, user: user1, post: post, created_at: 1.day.ago)
        comment3 = FactoryBot.create(:comment, user: user1, post: post, created_at: Time.current)
  
        expect(Comment.all).to eq([comment1, comment2, comment3])
      end
    end
  end
  
