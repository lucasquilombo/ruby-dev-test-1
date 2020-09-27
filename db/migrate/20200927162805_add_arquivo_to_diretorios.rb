class AddArquivoToDiretorios < ActiveRecord::Migration[6.0]
  def change
    add_column :diretorios, :arquivos, :json
  end
end
