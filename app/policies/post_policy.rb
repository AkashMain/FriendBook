class PostPolicy < ApplicationPolicy
  # class Scope < Scope
  #   # NOTE: Be explicit about which records you allow access to!
  #   # def resolve
  #   #   scope.all
  #   # end
  # end
  def index?
    true # Allow anyone to view the posts
  end

  def show?
    true # Allow anyone to view a specific post
  end

  def create?
    user.present? # Allow only authenticated users to create posts
  end

  # def update?
  #   user.present? && record.user == user # Allow only the post owner to update the post
  # end

  def destroy?
    user.present? && record.user == user # Allow only the post owner to delete the post
  end
  
end
