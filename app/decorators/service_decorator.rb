class ServiceDecorator < Draper::Decorator
  def format_for_status
    if object.blocked
      response_text = "#{name} is *blocked* by #{by} since #{from}"
      color = Service::NOT_OK_COLOR
      response_type = Service::EPHEMERAL_RESPONSE
    else
      response_text = "#{name} is *not blocked* and is ready for business"
      color = Service::OK_COLOR
      response_type = Service::EPHEMERAL_RESPONSE
    end

    {
      response_type: response_type,
      attachments: [{ color: color, text: response_text, mrkdwn_in: [:text] }]
    }
  end

  def format_for_block(user_id)
    response_text = "#{name} has been *blocked* by <@#{user_id}>"
    color = Service::OK_COLOR
    response_type = Service::IN_CHANNEL_RESPONSE

    {
      response_type: response_type,
      attachments: [{ color: color, text: response_text, mrkdwn_in: [:text] }]
    }
  end

  def format_for_unblock(user_id)
    response_text = "#{name} has been *unblocked* by <@#{user_id}>"
    color = Service::OK_COLOR
    response_type = Service::IN_CHANNEL_RESPONSE

    {
      response_type: response_type,
      attachments: [{ color: color, text: response_text, mrkdwn_in: [:text] }]
    }
  end

  def from
    object.blocked_at.strftime("%A, %B %e %I:%M%p")
  end

  def name
    "*#{object.short_name}*"
  end

  def by
    "<@#{object.blocked_by}>"
  end
end
