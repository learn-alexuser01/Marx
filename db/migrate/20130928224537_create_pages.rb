class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.references :owner, index: true
      t.string :privacy

      t.timestamps
    end
  end
end
