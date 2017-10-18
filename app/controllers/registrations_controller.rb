class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(sign_up_params)
    if @user.save
        redirect_to users_path, notice: "User succesfully created!"
    else
        render :new
    end
  end

  private

  def require_no_authentication
    assert_is_devise_resource!
    return unless is_navigational_format?
    no_input = devise_mapping.no_input_strategies

    authenticated = if no_input.present?
      args = no_input.dup.push scope: resource_name
      warden.authenticate?(*args)
    else
      warden.authenticated?(resource_name)
    end
    unless current_user.admin?
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to root_path
    end

  end

  def sign_up_params
    params.require(:user).permit(
      :first_name, :last_name, :role_id, :school_class_id, :subject_id,
      :email, :password, :password_confirmation
    )
  end
end
