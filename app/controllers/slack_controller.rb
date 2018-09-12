require 'json'

class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token

  rescue_from Exception, with: :render_error

  def create
    prms = permitted_params

    message = CommandService.new(user_id: prms[:user_id], text: prms[:text]).process

    SlackMessageSenderJob.perform_later(
      prms[:response_url],
      message.to_json
    )

    head 200
  end

  private

  def render_error(exception)
    SlackMessageSenderJob.perform_later(
      permitted_params[:response_url],
      {
        response_type: "ephemeral",
        attachments: [
          { color: "#FF0000", text: exception.message, mrkdwn_in: [:text] }
        ]
      }.to_json
    )
  end

  def permitted_params
    params.permit(
      :token,
      :command,
      :text,
      :response_url,
      :trigger_id,
      :user_id,
      :user_name,
      :team_id,
      :enterprise_id,
      :channel_id
    )
  end
end
