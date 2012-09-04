class RegistrationsController < Devise::RegistrationsController
  if Rails.env == 'production'
    def new
      flash[:notice] = 'Registrations are not open yet'
      redirect_to root_path
    end

    def create
      flash[:notice] = 'Registrations are not open yet'
      redirect_to root_path
    end
  end
end
