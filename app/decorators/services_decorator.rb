class ServicesDecorator < Draper::CollectionDecorator
  def format_for_status
    attachments = object.map do |service|
                    if service.blocked
                      response_text = "*#{service.name}* is *blocked* by <@#{service.blocked_by}> since #{service.blocked_at.strftime("%A, %B %e %I:%M%p")}"
                      color = Service::NOT_OK_COLOR
                    else
                      response_text = "#{service.name} is *not blocked* and is ready for business"
                      color = Service::OK_COLOR
                    end

                    { color: color, text: response_text, mrkdwn_in: [:text] }
                  end

    {
      response_type: Service::EPHEMERAL_RESPONSE,
      attachments: attachments
    }
  end
end
