class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :string
      t.belongs_to :word, index: true
      t.timestamps null: false
    end
  end
end
