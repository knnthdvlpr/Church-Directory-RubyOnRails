# app/controllers/api/positions_controller.rb
class Api::PositionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if params[:department_id].present?
      positions = Position.where(department_id: params[:department_id])
      positions_data = positions.map do |position|
        {
          id: position.id,
          name: position.name,
          unique: position.unique,
          available: position.available?
        }
      end
      render json: positions_data
    else
      render json: []
    end
  end
end