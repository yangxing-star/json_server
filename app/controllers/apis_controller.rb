class ApisController < ApplicationController

  def create
    api = Api.new api_params
    if api.save
      redirect_to action: :index
    else
      flash[:error] = api.errors.full_messages.to_s
      render 'apis/index'
    end
  end

  def index
    @apis = Api.all
  end

  def destroy
    api = Api.find(params[:id])
    if api.destroy
      render json: { success: true }
    else
      render json: { success: false, msg: api.errors.full_messages.to_s }
    end
  end

  def show
    api = Api.find_by(url: request.fullpath)
    render json: api.data
  end

  def detail
    api = Api.find(params[:id])
    render json: { api: api }
  end

  def update
    api = Api.find(params[:id])
    if api.update(api_params)
      render json: { success: true }
    else
      render json: { success: false, msg: api.errors.full_messages.to_s }
    end
  end

  private

  def api_params
    params.require(:api).permit( :url, :method, :data, :comment )
  end

end
