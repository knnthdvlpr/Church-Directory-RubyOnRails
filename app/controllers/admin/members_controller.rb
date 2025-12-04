# app/controllers/admin/members_controller.rb
class Admin::MembersController < ApplicationController
  before_action :require_admin
  before_action :set_member, only: [:show, :edit, :update, :suspend, :activate]

  def index
    @members = User.includes(:branch, :department, :position)
    
    # Search by name or email
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @members = @members.where(
        "first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?",
        search_term, search_term, search_term
      )
    end
    
    # Filter by branch
    if params[:branch_id].present?
      @members = @members.where(branch_id: params[:branch_id])
    end
    
    # Filter by department
    if params[:department_id].present?
      @members = @members.where(department_id: params[:department_id])
    end
    
    # Filter by status
    if params[:status].present?
      @members = @members.where(status: params[:status])
    end
    
    # Filter by baptismal status
    if params[:baptismal_status].present?
      @members = @members.where(baptismal_status: params[:baptismal_status])
    end
    
    @members = @members.order(created_at: :desc)
    
    # For filter dropdowns
    @branches = Branch.all
    @departments = Department.all
  end

  def show
  end

  def edit
    @branches = Branch.all
    @departments = @member.branch ? @member.branch.departments : Department.all
    @positions = @member.department ? @member.department.positions : Position.all
  end

  def update
    if @member.update(member_params)
      redirect_to admin_member_path(@member), notice: 'Member was successfully updated.'
    else
      @branches = Branch.all
      @departments = Department.all
      @positions = Position.all
      render :edit, status: :unprocessable_entity
    end
  end

  def suspend
    @member.update(status: 'Suspended')
    redirect_to admin_members_path, notice: 'Member has been suspended.'
  end

  def activate
    @member.update(status: 'Active')
    redirect_to admin_members_path, notice: 'Member has been activated.'
  end

  private

  def set_member
    @member = User.find(params[:id])
  end

  def member_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, 
                                  :age, :phone_number, :email, :baptismal_date,
                                  :branch_id, :department_id, :position_id, :status)
  end

  def require_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.has_role?(:admin)
  end
end