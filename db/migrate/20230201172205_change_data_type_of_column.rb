class ChangeDataTypeOfColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :extracts, :extract_length, :string 
  end
end
