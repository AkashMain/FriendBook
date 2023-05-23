require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

    let(:user0) {FactoryBot.create(:user)}
    let(:user00) {FactoryBot.create(:user, fname: "Commment", lname: "Yadav", email: "909@gmail.com")}
    let(:post0) {FactoryBot.create(:post, user: user0)}
    let(:comment0) { FactoryBot.create(:comment, post: post0, user: user00) }

    before do 
        sign_in user00 
    end

    describe 'GET#new' do 
        it "assigns a new comment to @comment" do 

            get :new, params: {post_id: post0.id}
            expect(assigns(:comment)).to be_a_new(Comment)
        end

        it "renders the new template" do 

            get :new, params: {post_id: post0.id}
            expect(response).to render_template(:new)

        end 
    end

    describe 'POST #create' do
        context 'with valid parameters' do

          # user00 = FactoryBot.create(:user, fname: "Commment", lname: "Yadav", email: "90909@gmail.com")
      
          let(:valid_params) do
            {post_id: post0.id, comment: { content: 'Great post!' } }
          end
          
          it 'creates a new comment' do
            expect {
              post :create, params: valid_params
            }.to change(Comment, :count).by(1)
          end
    
          it 'sets the flash notice' do
            post :create, params: valid_params
            expect(flash[:notice]).to eq('Comment was successfully created.')
          end
    
          it 'redirects to the post page' do
            post :create, params: valid_params
            expect(response).to redirect_to(post0)
          end
        end
    
        context 'with invalid parameters' do
          let(:invalid_params) do
            { post_id: post0.id, comment: { content: '' } }
          end
    
          it 'does not create a new comment' do
            expect {
              post :create, params: invalid_params
            }.not_to change(Comment, :count)
          end
    
          it 'renders the new template' do
            post :create, params: invalid_params
            expect(response).to render_template(:new)
          end
        end
    end

    describe 'GET #edit' do
  
      it 'assigns the requested comment to @comment' do
        get :edit, params: { id: comment0.id ,post_id: post0.id}
        expect(assigns(:comment)).to eq(comment0)
      end
  
      it 'renders the edit template' do
        get :edit, params: { id: comment0.id, post_id: post0.id }
        expect(response).to render_template(:edit)
      end
      
    end

    describe 'PATCH #update' do
      context 'with valid parameters' do
        let(:valid_params) do
          { id: comment0.id, post_id: post0.id, comment: { content: 'Updated comment' } }
        end

        it 'updates the comment' do
          patch :update, params: valid_params
          comment0.reload
          expect(comment0.content).to eq('Updated comment')
        end
    
        it 'redirects to the post page' do
          patch :update, params: valid_params
          expect(response).to redirect_to(post0)
        end
      end
    
      context 'with invalid parameters' do
        let(:invalid_params) do
          { id: comment0.id, post_id: post0.id, comment: { content: '' } }
        end
    
        it 'does not update the comment' do
          expect {
            patch :update, params: invalid_params
          }.not_to change { comment0.reload.content }
        end
    
        it 'renders the edit template' do
          patch :update, params: invalid_params
          expect(response).to render_template(:edit)
        end
      end
    end  

end