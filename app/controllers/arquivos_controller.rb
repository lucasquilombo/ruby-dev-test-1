class ArquivosController < ApplicationController
    before_action :set_diretorio
  
    def create
      add_more_arquivos(arquivos_params[:arquivos])
      flash[:error] = "Não foi possível salvar arquivo" unless @diretorio.save
      redirect_to diretorios_path(diretorio: params[:diretorio_id])
    end
  
    def destroy
        remove_image_at_index(params[:id].to_i)
        flash[:error] = "Não foi possível excluir arquivo" unless @diretorio.save
        redirect_to diretorios_path(diretorio: params[:diretorio_id])
    end
  
    private
  
    def set_diretorio
        @diretorio = Diretorio.find_by_id(params[:diretorio_id])
    end
  
    def add_more_arquivos(novos_arquivos)
      arquivos = @diretorio.arquivos 
      arquivos += novos_arquivos
      @diretorio.arquivos = arquivos
    end
  
    def remove_image_at_index(index)
        remain_arquivos = @diretorio.documentos
        if index == 0 && @diretorio.documentos.size == 1
            @diretorio.remove_arquivos!
        else
            deleted_image = remain_arquivos.delete_at(index) 
            deleted_image.try(:remove!)
            @diretorio.arquivos = remain_arquivos
        end
    end
  
    def arquivos_params
        params.require(:diretorio).permit({arquivos: []})
    end
  end