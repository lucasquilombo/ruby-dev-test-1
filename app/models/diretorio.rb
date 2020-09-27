class Diretorio < ApplicationRecord

    mount_uploaders :arquivos, ArquivoUploader

    scope :diretorio_atual,
        lambda{ |diretorio_pai|
            if diretorio_pai.present?
                self.where("diretorio_pai_id = ?", diretorio_pai)
            else
                self.where("diretorio_pai_id is null")
            end
        }

    has_many :diretorios, class_name: "diretorio"

    belongs_to :diretorio_pai,
        class_name: "diretorio",
        optional: true,
        foreign_key: "diretorio_pai_id"

    validates :nome,
        presence: true,
        uniqueness: {
            case_sensitive: false,
            scope: :diretorio_pai_id
        },
        length: {maximum: 50}
end
