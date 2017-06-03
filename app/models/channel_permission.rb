# frozen_string_literal: true

# == Schema Information
#
# Table name: channel_permissions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  channel_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Permissions for reading channel logs
class ChannelPermission < ApplicationRecord
  belongs_to :user
  belongs_to :channel
end
