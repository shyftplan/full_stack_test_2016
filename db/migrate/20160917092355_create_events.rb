class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.index      :id
      t.string     :name, default: ''
      t.datetime   :started_at, :null => false
      t.datetime   :finished_at, :null => false
      t.datetime   :deleted_at
      t.timestamps :null => false
    end
  end
end
