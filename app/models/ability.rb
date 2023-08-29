
class Ability
  include CanCan::Ability

  def initialize(user)

    return unless user.present?
    can :manage, Post, author_id: user.id # if the user is logged in can manage it's own posts
    can :manage, Comment, author_id: user.id # logged in users can also create comments
    return unless user.admin?
    can :manage, :all # finally we give all remaining permissions only to the admins
  end
end
