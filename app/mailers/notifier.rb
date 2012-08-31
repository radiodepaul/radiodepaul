class Notifier < ActionMailer::Base
  default from: "radiodepaulwebmaster@gmail.com"

  def application_email(application)
    @application = application
    mail(:to => application.email, :subject => 'Radio DePaul Application Confirmation')
  end

end
