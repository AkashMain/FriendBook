module Api
  module V1
      class PostsController<ApplicationController
          skip_before_action :authenticate_user!
          skip_before_action :verify_authenticity_token
            
          def index 
            @posts = Post.order(created_at: :desc).paginate(page: params[:page], per_page: 5)

            render json: {data: ActiveModelSerializers::SerializableResource.new(@posts, each_serializer: PostSerializer), 
              meta: {
                total_pages: @posts.total_pages,
                current_page: @posts.current_page
            }}

            # render json: {posts: @posts, total_pages: @posts.total_pages, current_page: @posts.current_page}  

          end
      end
  end
end

# NOTE: ActiveModel::SerializableResource.new is deprecated; use ActiveModelSerializers::SerializableResource. instead

            

            

