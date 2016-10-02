# frozen_string_literal: true
class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def show?
      if user.admin?
        true
      else
        scope.where(id: user.channels).exists?
      end
    end

    def resolve
      if user
        scope.where(channel: user.channels)
      else
        scope.where(channel: [])
      end
    end
  end
end
