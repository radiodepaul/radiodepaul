class UserName
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def fullname
    return anonymized if user.hide_fullname?
    "#{user.first_name} #{user.last_name}"
  end

  def last_first_name
    "#{user.last_name}, #{user.first_name}"
  end

  def anonymized
    "#{user.first_name} #{user.last_name[0]}"
  end
end
