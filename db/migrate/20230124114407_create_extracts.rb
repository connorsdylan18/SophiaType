class CreateExtracts < ActiveRecord::Migration[7.0]
  def change
    create_table :extracts do |t|
      t.text :extract_text
      t.string :extract_title
      t.integer :extract_length

      t.timestamps
    end
  end
end
