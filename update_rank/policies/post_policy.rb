class PostPolicy < ApplicationPolicy

  # Override index method in application_policy.rb
  def index?
    true
  end

  def destroy?
    # We want to give moderators the ability to delete posts too, not just
    # admins...
    # Eliot - what does the record.user bit do?
    user.present? && (record.user == user || user.admin? || user.moderator?)
  end
end
