class Admin::RegistrationsController < ApplicationController
  before_action :ensure_employee

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)
    if @admin_user.save
      redirect_to root_path, notice: '管理者アカウントが作成されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def admin_user_params
    params.require(:admin_user).permit(:last_name, :first_name, :username, :company, :phone_number, :email, :encrypted_password,)
  end

  def ensure_employee
    unless current_user.employee?
      redirect_to root_path, alert: '管理者登録は社員のみ可能です'
    end
  end

end
