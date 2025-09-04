class HomePolicy < ApplicationPolicy
  def show_links?
    user.present?
  end
end
