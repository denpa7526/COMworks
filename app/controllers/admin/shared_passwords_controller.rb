class Admin::SharedPasswordsController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :ensure_company_has_no_shared_password, only: [:new, :create]

  def new
    @shared_password = current_admin_user.company.build_shared_password
  end

  def create
    @shared_password = current_admin_user.company.build_shared_password(shared_password_params)
    if @shared_password.save
      Rails.logger.info "Shared password created for company: #{current_admin_user.company.name}"
      redirect_to admin_company_dashboard_path(current_user.admin_user.company), notice: '社内共通パスワードが正常に設定されました'
    else
      Rails.logger.warn "Failed to create shared password for company: #{current_admin_user.company.name}"
      Rails.logger.warn "Errors: #{@shared_password.errors.full_messages.join(', ')}"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @shared_password = current_admin_user.company.shared_password
  end

  def update
    @shared_password = current_admin_user.company.shared_password
    if @shared_password.update(shared_password_params)
      Rails.logger.info "Shared password updated for company: #{current_admin_user.company.name}"
      redirect_to admin_company_dashboard_path(current_user.admin_user.company), notice: '社内共通パスワードが正常に更新されました'
    else
      Rails.logger.warn "Failed to update shared password for company: #{current_admin_user.company.name}"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def authenticate_admin_user!
    unless current_admin_user
      Rails.logger.warn "Unauthorized access attempt to SharedPasswordsController"
      redirect_to root_path, alert: '管理者のみがアクセス可能です'
    end
  end
  
  def ensure_company_has_no_shared_password
    if current_admin_user.company.shared_password.present?
      Rails.logger.info "Existing shared password detected for company: #{current_admin_user.company.name}"
      redirect_to edit_admin_company_shared_password_path(current_user.admin_user.company), alert: '社内共通パスワードは既に設定されています。更新する場合は編集してください。'
    else
      Rails.logger.info "No existing shared password for company: #{current_admin_user.company.name}"
    end
  end

  def shared_password_params
    params.require(:shared_password).permit(:password, :password_confirmation)
  end
  
end
