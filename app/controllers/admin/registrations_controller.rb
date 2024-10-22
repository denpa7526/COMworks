class Admin::RegistrationsController < ApplicationController
  before_action :authenticate_employee!

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)
    if @admin_user.save
      redirect_to new_admin_company_shared_password_path(@admin_user.company_id), notice: '管理者アカウントが作成されました。社内共通パスワードを設定してください。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(:last_name, :first_name, :phone_number, :email, :password, :password_confirmation).merge(user_id: current_user.id, company_id: current_user.company_id)
  end

  def authenticate_employee!
    unless current_user&.employee?
      redirect_to root_path, alert: '管理者登録は社員のみ可能です'
    end
  end

end
