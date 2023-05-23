require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    
    let(:user0) {FactoryBot.create(:user)}
    let(:post0) {FactoryBot.create(:post, user: user0)}
    let(:post00) {FactoryBot.create(:post, body: "123456789",created_at: 1.day.ago, user: user0)}
    
    before do 
        sign_in user0
    end

    describe 'GET #index' do 
        it "it assigns the all posts ordered by created_at" do 
            post1 = FactoryBot.create(:post, created_at: 1.day.ago, user: user0)
            post2 = FactoryBot.create(:post, body: "987654321", created_at: 2.day.ago, user: user0)
            # binding.pry

            get :index 
            # expect(assigns(:posts)).to eq(Post.order(created_at: :desc))

            expect(assigns(:posts)).to match_array([post1, post2])    
        end 

        it "searches posts based on the search parameter" do
            post1 = FactoryBot.create(:post, body: "Hello World", user: user0)
            post2 = FactoryBot.create(:post, body: "Goodbye World", user: user0)
      
            get :index, params: { search: "Hello" }
      
            expect(assigns(:posts)).to eq([post1])
        end

        it "paginates the post with 5 pages per page" do 
            FactoryBot.create_list(:post,7, user: user0)

            get :index 
            expect(assigns(:posts).total_pages).to eq(2)
            expect(assigns(:posts).current_page).to eq(1)
            # binding.pry
            expect(assigns(:posts).length).to eq(5)

        end

        it "renders the index template" do 
            
            get :index 
            expect(response).to render_template(:index)
        end

        # it "responds to JS format" do
        #     get :index, format: :js
      
        #     expect(response.content_type).to eq("text/javascript")                    # protect_from_forgery except: :index
        # end
    end

    describe 'GET#show' do 
        it 'assigns the requested post to @post' do 

            get :show, params: {id: post0.id}
            expect(assigns(:post)).to eq(post0)
        end

        it "assgins the new comment to @post" do 

            get :show, params: {id: post0.id}
            expect(assigns(:comment)).to be_a_new(Comment)
        end

        it "render the show template" do 
            get :show, params: {id: post0.id}
            expect(response).to render_template(:show)
        end
    end

    describe 'GET#new' do 
        it "assigns new post to @post" do 
            get :new 
            expect(assigns(:post)).to be_a_new(Post)
        end

        it "renders new template" do 
            get :new 
            expect(response).to render_template(:new)
        end
    end

    describe 'POST#create' do 

        context 'with valid parameters' do
            let(:valid_params) do
                { post: { body: 'Hello, world!' } }
            end
            # let(:valid_params) {FactoryBot.create(:post, body: "Hello, world!", user: user0)}
            
            it 'creates a new post' do
                expect {
                    post :create, params: valid_params
                }.to change{Post.count}.by(1)                          #change(Post, :count)
            end
  
            it 'sets the flash notice' do
                post :create, params: valid_params
                expect(flash[:notice]).to eq('Post was successfully created')
            end
  
            it 'redirects to the posts index page' do
                post :create, params: valid_params
                expect(response).to redirect_to(posts_path)
            end

        end
  
        context 'with invalid parameters' do
            let(:invalid_params) do
                { post: { body: '' } }
            end
  
            it 'does not create a new post' do
                expect {
                    post :create, params: invalid_params
                }.not_to change(Post, :count)
            end
  
            it 'renders the new template' do
                post :create, params: invalid_params
                expect(response).to render_template(:new)
            end
        end
    end
end