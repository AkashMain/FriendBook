module FriendshipsHelper

    def accepted_request(accepted_requests)
        @accepted_requests.each do |request| 
            link_to request.receiver.fname, request.receiver
        end
    end

    def declined_request(declined_requests)
        @declined_requests.each do |request|
            link_to request.receiver.fname, request.receiver
        end
    end

    def send_friends_request(users)
        @users.each do |user| 
            link_to user.fname, create_request_user_friendship_path(user.id, user_id: current_user), method: :post, remote: true 
        end 
    end

    def friends_show(fr)
        @fr.each do |f|
            if f.sender.fname==current_user.fname
                f.receiver.fname
                link_to 'Destroy friendship', user_friendship_path(current_user, f), method: :delete, data: { confirm: "Are you sure you want to unfriend #{f.receiver.fname}?" }, style: 'color:#CD5C5C'
            else
                f.sender.fname
                ink_to 'Destroy friendship', user_friendship_path(current_user, f), method: :delete, data: { confirm: "Are you sure you want to unfriend #{f.receiver.fname}?" }, style: 'color:#CD5C5C'
            end
          end
    end
end
