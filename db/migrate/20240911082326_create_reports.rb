class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :report_type
      t.text :content

      t.timestamps
    end
  end
end
