module Mailer
  include SendGrid

  def self.test
    from = Email.new(email: 'test@thefutureproject.org')
    subject = 'Hello World from the SendGrid Ruby Library!'
    to = Email.new(email: 'chris.frank@thefutureproject.org')
    content = Content.new(type: 'text/plain', value: 'Hello, Email!')
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end

  def self.deliver_possibility_profile(profile)
    from = Email.new('email': 'noreply@thefutureproject.org', 'name': 'The Future Project')
    subject = 'Your Possibility Profile Results'
    to = Email.new('email': profile.email_address)
    @profile = profile
    template = File.read("#{App.root}/views/mailers/possibility_profile.erb")
    body = ERB.new(template).result(binding)
    content = Content.new(
      type: 'text/html',
      value: body
    )
    mail = Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    true
  end

end
