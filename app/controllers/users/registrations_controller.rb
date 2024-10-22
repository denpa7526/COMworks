class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    build_resource(sign_up_params.except(:company, :shared_password))

    if resource.employee?
      company_name = params[:user][:company]
      company = Company.find_or_create_by!(name: company_name)
      resource.company = company

      shared_password = params[:user][:shared_password]
      first_employee = company.users.employee.empty?

      if first_employee
        valid_password = SharedPassword.valid_initial_password?(shared_password)
      else
        valid_password = company.shared_password&.authenticate(shared_password)
      end

      unless valid_password
        resource.errors.add(:shared_password, "が無効です")
        return render :new, status: :unprocessable_entity
      end
    end

    resource.shared_password = shared_password
    resource.save
    yield resource if block_given?    #ブロックが与えられている場合、そのブロックを実行

    if resource.persisted?            #ユーザーオブジェクトがデータベースに保存されたかどうか
      if resource.active_for_authentication?  #ログイン可能な状態であるかどうか
        sign_up(resource_name, resource)

        if resource.employee? && first_employee
          redirect_to new_admin_registration_path, notice: '社内の最初の社員として登録されました。管理者アカウントを作成してください。'
        else
          respond_with resource, location: after_sign_up_path_for(resource)
        end

      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end

    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def configure_sign_up_params
    keys = [:last_name, :first_name, :username, :position, :phone_number, :role]
    keys += [:company, :shared_password] if params[:user][:role] == 'employee'
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
  end

  def after_sign_up_path_for(resource)
    if resource.employee? && resource.company.users.employee.count == 1
      new_admin_registration_path
    else
      root_path
    end
  end
end