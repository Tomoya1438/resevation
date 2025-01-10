class Admin::JoinsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @joins = Join.all
  end

  def destroy
    @join = Join.find_by_id(params[:id])
    @join&.destroy
    flash[:noticce] = "削除しました"
    redirect_to admin_joins_path
  end
end
