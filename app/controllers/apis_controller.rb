class ApisController < ApplicationController
  before_action :require_user, except: :show
  before_action :find_api, only: [ :destroy, :detail, :update ]

  def create
    api = @current_user.apis.new(url: params[:url], method: params[:method], comment: params[:comment], data: params[:data].to_json)
    if api.save
      render json: { success: true }
    else
      flash[:error] = api.errors.full_messages.to_s
      redirect_to action: :index
    end
  end

  def index
    @apis = @current_user.apis
  end

  def destroy
    if @api.destroy
      render json: { success: true }
    else
      render json: { success: false, msg: @api.errors.full_messages.to_s }
    end
  end

  def show
    api = Api.find_by(url: request.fullpath)
    render json: api.data
  end

  def detail
    render json: { api: @api }
  end

  def update
    if @api.update(url: params[:url], method: params[:method], comment: params[:comment], data: params[:data].to_json)
      render json: { success: true }
    else
      render json: { success: false, msg: @api.errors.full_messages.to_s }
    end
  end

  private

  def find_api
    @api = @current_user.apis.find(params[:id])
  end

end
