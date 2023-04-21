class DeleteFriendshipJobJob < ApplicationJob
  queue_as :default
                                                                          
  def perform(freindship_id)
    # Do something later
    Friendship.find(freindship_id).destroy                          #This job will delete a friendship record when it is enqueued.
  end
end
