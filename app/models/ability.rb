class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Person.new

    if user.has_role? :admin
      can :manage, :all

    elsif user.has_role? :manager
      can [:read, :create, :update], :all

    elsif user
      can [:read, :update], Show, id: user.show_ids
      can [:read, :update], Person, id: user.id
      can :read, [Event, Podcast, NewsPost, Award]
    end
  end
end
