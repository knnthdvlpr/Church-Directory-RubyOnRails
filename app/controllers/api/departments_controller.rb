# app/controllers/api/departments_controller.rb
class Api::DepartmentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:branch_id].present?
      departments = Department.where(branch_id: params[:branch_id])
      render json: departments.select(:id, :name)
    else
      render json: []
    end
  end
end