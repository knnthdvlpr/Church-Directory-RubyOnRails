module Branches
  class DepartmentsController < ApplicationController
    before_action :set_branch
    before_action :set_department, only: %i[ show edit update destroy ]
    load_and_authorize_resource
    
    # GET /departments or /departments.json
    def index
      @departments = @branch.departments.all
    end

    # GET /departments/1 or /departments/1.json
    def show
    end

    # GET /departments/new
    def new
      @department = @branch.departments.new
    end

    # GET /departments/1/edit
    def edit
    end

    # POST /departments or /departments.json
    def create
      @department = @branch.departments.new(department_params)

      respond_to do |format|
        if @department.save
          format.html { redirect_to [@branch, @department], notice: "Department was successfully created." }
          format.json { render :show, status: :created, location: @department }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @department.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /departments/1 or /departments/1.json
    def update
      respond_to do |format|
        if @department.update(department_params)
          format.html { redirect_to [@branch, @department], notice: "Department was successfully updated.", status: :see_other }
          format.json { render :show, status: :ok, location: @department }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @department.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /departments/1 or /departments/1.json
    def destroy
      @department.destroy!

      respond_to do |format|
        format.html { redirect_to branch_departments_path(@branch), notice: "Department was successfully destroyed.", status: :see_other }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_department
        @department = @branch.departments.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def department_params
        params.expect(department: [ :name, :description])
      end

      def set_branch
        @branch = Branch.find(params.expect(:branch_id))
      end
  end
end