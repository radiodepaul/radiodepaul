class Notifier < ActionMailer::Base
  default from: "radiodepaulwebmaster@gmail.com"

  def application_confirmation(application)
    @application = application
    mail(:to => application.email, :subject => 'Radio DePaul Application Confirmation')
  end

  def welcome(person, new_password)
    @person = person
    @new_password = new_password
    @person.reset_authentication_token!
    mail(:to => person.email, :subject => 'Your Radio DePaul Account')
  end

end
