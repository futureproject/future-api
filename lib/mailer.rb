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

  def self.deliver_possibility_profile(args)
    from = Email.new('email': 'noreply@thefutureproject.org', 'name': 'The Future Project')
    subject = 'Your Possibility Profile Results'
    to = Email.new('email': args[:email])
    content = Content.new(
      type: 'text/plain',
      value: "Your results from the Possibility Profile are ready! You can view them here: #{args[:profile_url]}"
    )
    mail = Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    true
  end

end
