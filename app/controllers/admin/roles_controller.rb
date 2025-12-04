# app/controllers/admin/roles_controller.rb
class Admin::RolesController < ApplicationController
  before_action :require_admin

  def index
    @users = User.includes(:roles).order(:last_name, :first_name)
    @available_roles = Role.all
  end

  def update
    @user = User.find(params[:id])
    
    # Remove all existing roles
    @user.roles = []
    
    # Add selected roles
    if params[:role_ids].present?
      params[:role_ids].each do |role_id|
        role = Role.find(role_id)
        @user.add_role(role.name)
      end
    end
    
    redirect_to admin_roles_path, notice: "Roles updated for #{@user.full_name}"
  end

  private

  def require_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.has_role?(:admin)
  end
end