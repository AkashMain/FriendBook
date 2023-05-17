class CreateDelayedPostJob < ApplicationJob
  queue_as :default

  def perform(user_id,post_params)
    # Do something later
    user = User.find_by(id: user_id)

    if user.present?
      post = user.posts.build(post_params)
      post.save
    end

  end
end
# class CreateDelayedPostJob < ApplicationJob
#   queue_as :default

#   def perform(post_id)
#     post = Post.find_by(id: post_id)

#     if post.present?
#       post.save
#     end
#   end
# end