class TopicPolicy < ApplicationPolicy

  ## index? simply allows anybody to view a list of topics,
  ## overriding the default of false on ApplicationPolicy
  def index?
    true
  end


  ## create? is defined so only admins will be able to create topics.
  def create?
    user.present? && user.admin?
  end


  ## Similarly we defined update? to delegate to
  ## create?, so that only admins will be able to update topics as well.
  def update?
    create?
  end
 end
