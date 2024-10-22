class Admin::CompaniesController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :ensure_company_access!

  def show
    @company = Company.find(params[:id])
  end

  private

  def authenticate_admin_user!
    redirect_to root_path, alert: '管理者のみアクセス可能です' unless current_user&.admin_user
  end

  def ensure_company_access!
    company = Company.find(params[:id])
    unless current_user.admin_user.company == company
      redirect_to admin_company_dashboard_path(current_user.admin_user.company), alert: 'アクセス権限がありません'
    end
  end
end
