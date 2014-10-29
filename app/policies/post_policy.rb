class PostPolicy < ApplicationPolicy

  # Override index method in application_policy.rb
  def index?
    true
  end
end
