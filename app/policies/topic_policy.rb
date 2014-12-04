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

  ## Used to determine whether or not a user not signed in should
  ## see a topic or not. Below says, is the record public? or User signed in?
  def show?
    record.public? || user.present?
  end

 end
