class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.string :ip_address
      t.string :isWhitelisted
      t.timestamps
    end
  end
end
