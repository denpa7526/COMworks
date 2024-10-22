class Admin::SessionsController < ApplicationController
  before_action :authenticate_employee!

  def new
  end

  def create
    @admin_user = AdminUser.find_by(email: params[:email])
    if @admin_user && @admin_user.authenticate(params[:password])
      session[:admin_user_id] = @admin_user.id
      redirect_to admin_company_dashboard_path(@admin_user.company_id), notice: 'ログインに成功しました'
    else
      flash.now[:alert] = '入力内容が無効です'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end


  private

  def authenticate_employee!
    unless current_user&.employee?
      redirect_to root_path, alert: '管理者ログインは社員のみ可能です'
    end
  end

end
