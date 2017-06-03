# frozen_string_literal: true

json.extract! @message, :id, :text, :user, :command, :created_at, :updated_at
