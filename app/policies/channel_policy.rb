# frozen_string_literal: true
class ChannelPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user
        if user.admin?
          scope.all
        else
          scope.where(id: user.channels)
        end
      else
        scope.none
      end
    end
  end
end
