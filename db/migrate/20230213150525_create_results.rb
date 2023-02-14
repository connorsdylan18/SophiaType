class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.float :time
      t.decimal :accuracy
      t.float :grossWPM
      t.float :netWPM
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
