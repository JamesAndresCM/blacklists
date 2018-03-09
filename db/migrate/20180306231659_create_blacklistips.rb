class CreateBlacklistips < ActiveRecord::Migration[5.1]
  def change
    create_table :blacklistips do |t|
      t.string :ip_address
      t.string :central_report
      t.string :status_ip
      t.string :hostname
      t.string :url_central_report

      t.timestamps
    end
  end
end
