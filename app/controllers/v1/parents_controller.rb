module V1
  class ParentsController < ApplicationController
    before_action :ensure_parent, only: %i[show destroy update add_student students]

    def index
      render(json: Parent.all)
    end

    def create
      new_parent = Parent.create!(permitted_params)

      render(json: new_parent)
    end

    def show
      render(json: parent)
    end

    def update
      parent.update(permitted_params)

      show
    end

    def destroy
      parent.destroy

      show
    end

    def add_student
      student = Student.where(_id: params.require(:student_id)).first
      return head 404 unless student.present?
      parent.students << student
      head :no_content
    end

    def students
      render json: parent.students
    end

    private

    def permitted_params
      params.permit(:name)

    end

    def parent
      @parent ||= Parent.where(_id: params.require(:id)).first
    end

    def ensure_parent
      head :not_found unless parent.present?
    end

  end
end
