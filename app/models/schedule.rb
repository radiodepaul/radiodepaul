class Schedule < ActiveRecord::Base
  attr_accessible :name, :code, :start_date, :end_date

  has_many :slots

  validates_uniqueness_of :code, :case_sensitive => false

  before_save :upcase_code

  def self.find_by_code(code)
    super(code.upcase)
  end

  private

  def upcase_code
    self.code.upcase!
  end

end
