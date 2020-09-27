class CreateDiretorios < ActiveRecord::Migration[6.0]
    def change
        create_table :diretorios do |t|
            t.string :nome
            t.integer :diretorio_pai_id

            t.timestamps
        end
    end
end
