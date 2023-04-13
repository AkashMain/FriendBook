module PostsHelper

    def post_author(post)
        "=>> #{post.user.fname}"
    end

    def delete_post(post)
        link_to 'Delete', post_path(post.id), method: :delete, data: {confirm: "Do you want to delete this post"},style: 'color:#E34234'
    end

    def like_button_post(post)
        like = Like.find_by(user_id: current_user.id, likable_type: "Post", likable_id: post.id)
        if like.present?
            button_to post_like_path(like.likable_id, like.id, likable_type: "Post"), method: :delete, remote: true, style: 'color:#E34234' do
                content_tag(:span, '👎')
            end
        else
            button_to post_likes_path(post), method: :post,remote: true, style: 'color:#2E8B57' do
                content_tag(:span, '👍')
            end
        end
    end

    def post_author(comment)
        "-> #{comment.user.fname}"
    end

    def like_button_comment(post,comment)
        like = Like.find_by(user_id: current_user.id, likable_type: "Comment", likable_id: comment.id)
        if like.present?
            button_to post_comment_like_path(@post.id,like.likable_id,like.id,likable_type: "Comment"), method: :delete, remote:true, style: 'color:#E34234' do
                content_tag(:span, '👎')
            end
        else
            button_to post_comment_likes_path(@post.id,comment.id), method: :post, remote:true, style: 'color:#2E8B57' do
                content_tag(:span, '👍')
            end
        end
    end

end
