class ServicesDecorator < Draper::CollectionDecorator
  def format_for_status
    attachments = object.map do |service|
                    if service.blocked
                      response_text = "#{name(service)} is *blocked* by #{by(service)} since #{from(service)}"
                      color = Service::NOT_OK_COLOR
                    else
                      response_text = "#{name(service)} is *not blocked* and is ready for business"
                      color = Service::OK_COLOR
                    end

                    { color: color, text: response_text, mrkdwn_in: [:text] }
                  end

    {
      response_type: Service::EPHEMERAL_RESPONSE,
      attachments: attachments
    }
  end

  private

  def from(service)
    service.blocked_at.strftime("%A, %B %e %I:%M%p")
  end

  def name(service)
    "*#{service.short_name}*"
  end

  def by(service)
    "<@#{service.blocked_by}>"
  end
end
