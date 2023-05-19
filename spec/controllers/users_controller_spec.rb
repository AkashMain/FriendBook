require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    
    let(:user0) {FactoryBot.create(:user)}
    let(:user00) {FactoryBot.create(:user, email: "nono@gmail.com")}
    
    before do
        # user0 = FactoryBot.create(:user)
        sign_in user0
    end

    describe "GET #index" do
        it "assigns all users ordered by fname to @users" do 
            get :index 
            expect(assigns(:users)).to eq(User.order(:fname))
        end

        it "renders the index template" do
            get :index
            expect(response).to render_template(:index)
        end
    end

    describe "GET #show" do
        it "assigns the requested user to @user" do
          get :show, params: { id: user0.id }
          expect(assigns(:user)).to eq(user0)
        end
    
        it "assigns the user's posts to @posts" do
          get :show, params: { id: user0.id }
          expect(assigns(:posts)).to eq(user0.posts.order(created_at: :desc))
        end
    
        it "assigns the user's friends to @friends" do
          get :show, params: { id: user0.id }
          expect(assigns(:friends)).to eq(user0.friends)
        end
    
        it "renders the show template" do
          get :show, params: { id: user0.id }
          expect(response).to render_template(:show)
        end
    end
    
end
