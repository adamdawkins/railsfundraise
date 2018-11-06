# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:new, :create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource
    if params[:campaign_type] == "birthday"
      self.resource.campaigns.build
    end
  end

  # POST /resource
  def create
    birthday = sign_up_params[:birthday]
    resource = build_resource(sign_up_params.except(:birthday))
    if resource.save
      campaign = create_campaign resource, birthday
      campaign.save
      redirect_to campaign
    else
      render :new and return
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:full_name, :campaign_type, birthday: [:day, :month] ]
    )
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    campaign_path resource.campaigns.first
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def create_campaign(user, birthday)
    Campaign.new_landing_campaign(params[:campaign_type], user, birthday)
  end
end
