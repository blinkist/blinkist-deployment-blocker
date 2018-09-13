class Service < ApplicationRecord
  OK_COLOR = "#2CE080"
  NOT_OK_COLOR = "#03314B"
  ERROR_COLOR = "#FF0000"

  EPHEMERAL_RESPONSE = "ephemeral"
  IN_CHANNEL_RESPONSE = "in_channel"

  MAX_BLOCKING_TIME = 4.hours

  def block_for(user_id)
    if self.blocked
      raise "*#{self.short_name}* is already blocked by <@#{self.blocked_by}>"
    end

    self.blocked = true
    self.blocked_by = user_id
    self.blocked_at = Time.now
    self.save!
  end

  def unblock_for(user_id)
    if self.blocked
      unless self.blocked_by == user_id || (Time.now - self.blocked_at > MAX_BLOCKING_TIME)
        raise "*#{self.short_name}* must be unblocked by <@#{self.blocked_by}>. Please contact personally"
      end

      self.blocked = false
      self.blocked_by = nil
      self.blocked_at = nil
      self.save!
    end
  end
end
