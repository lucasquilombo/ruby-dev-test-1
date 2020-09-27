class DiretoriosController < ApplicationController
    def index
        @diretorios = Diretorio.diretorio_atual(params[:diretorio]).order(:nome)
        @novo_diretorio = Diretorio.new
        
        @diretorio = Diretorio.find_by_id(params[:diretorio]) if params[:diretorio].present?
    end

    def create
        @diretorio = Diretorio.create(diretorio_params)
        
        if not @diretorio.valid?
            flash[:errors] = @diretorio.errors.full_messages
        end

        redirect_to diretorios_path(diretorio: params[:diretorio][:diretorio_pai_id])
    end

    def update
        @diretorio = Diretorio.find_by_id(params[:id])
        if not @diretorio.update(diretorio_params)
            flash[:errors] = @diretorio.errors.full_messages
        end

        redirect_to diretorios_path(diretorio: params[:diretorio][:diretorio_id])
    end

    def destroy
    end

    private

    def diretorio_params
        # params.require(:diretorio).permit(:nome, :diretorio_pai_id, {arquivos: []})
        params.require(:diretorio).permit(:nome, :diretorio_pai_id)
    end
end
