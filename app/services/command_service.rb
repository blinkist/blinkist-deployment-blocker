class CommandService
  attr_accessor :service_name, :command, :user_id

  def initialize(user_id:, text:)
    command = (text || "").split.compact

    @user_id = user_id

    @command = command.first || "help"
    @service_name = command.second
  end

  def process
    case @command.to_sym
    when :help
      process_help_command
    when :status
      process_status_command
    when :block
      process_block_command
    when :unblock
      process_unblock_command
    else
      raise "Cannot understand #{command}. Please try *help*"
    end
  end

  private

  def process_help_command
    {
      "attachments": [
          {
              "color": "#2CE080",
              "pretext": "Blinkist Service Blocking Status",
              "author_name": "Blinkist",
              "author_link": "http://github.com/blinkist",
              "author_icon": "https://avatars1.githubusercontent.com/u/2903478?s=200&v=4",
              "title": "BlinkistService Usage : /blinkistservice <command>\nCommand Options",
              "fields": [
                  {
                    "title": "status",
                    "value": "Get block/unblock status of all services",
                    "short": false
                  },
                  {
                      "title": "status <service-name>",
                      "value": "Get block/unblock status of a service",
                      "short": false
                  },
                  {
                      "title": "block <service-name>",
                      "value": "Block a service",
                      "short": false
                  },
                  {
                      "title": "unblock <service-name>",
                      "value": "Unblock a service",
                      "short": false
                  }
              ],
              "footer": "Blinkist"
          }
      ]
    }
  end

  def process_status_command
    service = Service.find_by_short_name(@service_name)

    if service.nil?
      ServicesDecorator.decorate(Service.all.to_a).format_for_status
    else
      ServiceDecorator.decorate(service).format_for_status
    end
  end

  def process_block_command
    service = service_from_params

    service.block_for(@user_id)

    ServiceDecorator.decorate(service).format_for_block
  end

  def process_unblock_command
    service = service_from_params

    service.unblock_for(@user_id)

    ServiceDecorator.decorate(service).format_for_unblock
  end

  def service_from_params
    raise "Service name required" if @service_name.nil?

    service = Service.find_by_short_name(@service_name)

    raise "#{@service_name} is not found" if service.nil?

    service
  end
end
