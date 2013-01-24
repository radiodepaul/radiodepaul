class Schedule < ActiveRecord::Base
  attr_accessible :name, :code, :start_date, :end_date

  has_many :slots
  has_many :shows, through: :slots
  has_many :hosts, through: :shows

  validates_uniqueness_of :code, :case_sensitive => false

  before_save :upcase_code

  def self.find_by_code(code)
    super(code.upcase)
  end

  def self.current
    self.current_schedule || self.default_schedule
  end

  private

  def self.current_schedule
    self.all.find {|schedule| (schedule.start_date..schedule.end_date).include? Date.current}
  end

  def self.default_schedule
    self.last
  end

  def upcase_code
    self.code.upcase!
  end
end
