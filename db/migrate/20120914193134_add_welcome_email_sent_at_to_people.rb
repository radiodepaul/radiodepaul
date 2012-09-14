class AddWelcomeEmailSentAtToPeople < ActiveRecord::Migration
  def up
    add_column :people, :welcome_email_sent_at, :datetime
  end
  def down
    remove_column :people, :welcome_email_sent_at
  end
end
