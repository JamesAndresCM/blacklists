class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :category_ip_blacklist
      t.references :report, foreign_key: true
      t.timestamps
    end
  end
end
