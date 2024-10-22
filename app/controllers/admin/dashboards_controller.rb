class Admin::DashboardsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_company
  before_action :ensure_company_access!

  def show
    @admin_user = current_user.admin_user
    @shared_password = @company.shared_password
  end

  private

  def authenticate_admin_user!
    redirect_to root_path, alert: '管理者のみアクセス可能です' unless current_user&.admin_user
  end

  def set_company
    @company = current_user.admin_user.company
  end

  def ensure_company_access!
    company = Company.find_by(id: params[:company_id])
    if company.nil? || company != @company
      redirect_to admin_company_dashboard_path(@company), alert: 'アクセス権限がありません'
    end
  end
end
