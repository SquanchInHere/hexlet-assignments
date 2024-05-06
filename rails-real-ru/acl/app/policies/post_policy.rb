# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def new?
    user
  end

  def create?
    new?
  end

  def edit?
    record.author == user || user&.admin?
  end

  def update?
    edit?
  end

  def destroy?
    user&.admin?
  end
end
