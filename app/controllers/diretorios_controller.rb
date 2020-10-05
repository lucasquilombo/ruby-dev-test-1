class DiretoriosController < ApplicationController
    respond_to :html, :js, only: [:index]

    def index
        @novo_diretorio = Diretorio.new

        if params[:pagina].present?
            @pagina = params[:pagina].to_i + 1
        else
            @pagina = 1
        end

        if params[:diretorio].present?
            @diretorio = Diretorio.find(params[:diretorio])
            @documentos = @diretorio.documentos(pagina: @pagina)
        else
            @documentos = Diretorio.documentos_home(pagina: @pagina)
        end
    end

    def create
        @diretorio = Diretorio.create(diretorio_params)
        
        if not @diretorio.valid?
            flash[:errors] = @diretorio.errors.full_messages
        end

        redirect_to diretorios_path(diretorio: params[:diretorio][:diretorio_pai_id])
    end

    def update
        @diretorio = Diretorio.find(params[:id])
        if not @diretorio.update(diretorio_params)
            flash[:errors] = @diretorio.errors.full_messages
        end

        redirect_to diretorios_path(diretorio: params[:diretorio][:diretorio_id])
    end

    def destroy
        @diretorio = Diretorio.find(params[:id])
        diretorio_pai_id = @diretorio.diretorio_pai_id
        
        @diretorio.destroy

        redirect_to diretorios_path(diretorio: diretorio_pai_id)
    end

    private

    def diretorio_params
        params.require(:diretorio).permit(:nome, :diretorio_pai_id)
    end
end
