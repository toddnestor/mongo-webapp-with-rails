module V1
  class GradesController < ApplicationController
    before_action :ensure_student
    before_action :ensure_grade, only: %i[show update destroy]

    def index
      render(json: student.grades)
    end

    def create
      new_grade = student.grades.create!(permitted_params)

      render(json: new_grade)
    end

    def show
      render(json: grade)
    end

    def update
      grade.update(permitted_params)

      show
    end

    def destroy
      grade.destroy

      show
    end

    private

    def permitted_params
      params.permit(:course, :term, :value)
    end

    def student
      @student ||= Student.where(_id: params.require(:student_id)).first
    end

    def ensure_student
      head :not_found unless student.present?
    end

    def grade
      @grade ||= student.grades.where(_id: params.require(:id)).first
    end

    def ensure_grade
      head :not_found unless grade.present?
    end
  end
end
