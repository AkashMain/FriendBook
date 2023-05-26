class Ability
    include CanCan::Ability
  
    def initialize(user)
    #   user ||= User.new # Guest user (not logged in)
      can :read, Post # Regular users can read posts
      can :create, Post if user.persisted? # Only authenticated users can create posts
    #   can :update, Post, user_id: user.id # User can update their own posts
      can :destroy, Post, user_id: user.id # User can delete their own posts
  
    #   if user.admin?
    #     can :manage, :all # Admin users can manage all resources
    #   else
    #   end
    end
end

# letter_opener
# mail_jet, gmail

# pdf_renderin
# csv gener/download
# active admin
# elaticsearch
# mongodb
# sti

# sidekiq
