class Notifier < ActionMailer::Base
  default from: "radiodepaulwebmaster@gmail.com"

  def application_confirmation(application)
    @application = application
    mail(:to => application.email, :subject => 'Radio DePaul Application Confirmation')
  end

  def welcome(person)
    @person = person
    @person.reset_authentication_token!
    mail(:to => person.email, :subject => 'Your Radio DePaul Account')
  end

end
