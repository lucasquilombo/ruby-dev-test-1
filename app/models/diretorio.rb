class Diretorio < ApplicationRecord
    mount_uploaders :arquivos, ArquivoUploader

    has_many :diretorios, foreign_key: "diretorio_pai_id"
    belongs_to :diretorio_pai, optional: true

    validates :nome,
        presence: true,
        uniqueness: {
            case_sensitive: false,
            scope: :diretorio_pai_id
        },
        length: { maximum: 50 }

    
    def self.documentos_home(options = {})
        pagina = options[:pagina] || 1
        qtdRegistros = options[:qtdRegistros] || 2

        registros = where(diretorio_pai_id: nil).order(:nome)
        registros.paginate(page: pagina, per_page: qtdRegistros)
    end

    def documentos(options = {})
        pagina = options[:pagina] || 1
        qtdRegistros = options[:qtdRegistros] || 2

        registros = (diretorios + arquivos)
        registros = ordenar_lista(registros)
        registros.paginate(page: pagina, per_page: qtdRegistros)
    end

    private

    def ordenar_lista registros
        registros.sort_by do |registro|
            if registro.is_a? Diretorio
              registro.nome
            elsif registro.is_a? ArquivoUploader
              registro.file.filename
            end
        end
    end
end
