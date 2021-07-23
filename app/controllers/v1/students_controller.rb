module V1
  class StudentsController < ApplicationController
    before_action :ensure_student, only: %i[show destroy update]

    def index
      render(json: Student.all)
    end

    def create
      new_student = Student.create!(permitted_params)

      render(json: new_student)
    end

    def show
      render(json: student)
    end

    def update
      student.update(permitted_params)

      show
    end

    def destroy
      student.destroy

      show
    end

    private

    def permitted_params
      submitted_params = params.permit(:name, :birthdayDay, :birthdayMonth, :birthdayYear)

      params_hash = {}
      params_hash[:name] = submitted_params[:name] if submitted_params[:name].present?

      if [:birthdayDay, :birthdayMonth, :birthdayYear].all? { |key| submitted_params.key?(key) }
        params_hash[:birthday] = Date.new(submitted_params[:birthdayYear], submitted_params[:birthdayMonth], submitted_params[:birthdayDay])
      end

      params_hash
    end

    def student
      @student ||= Student.where(_id: params.require(:id)).first
    end

    def ensure_student
      head :not_found unless student.present?
    end
  end
end
