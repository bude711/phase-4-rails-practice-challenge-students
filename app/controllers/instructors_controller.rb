class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_message
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_found_message

    def index 
        render json: Instructor.all
    end

    def show 
        instructor = Instructor.find(params[:id])
        render json: instructor      
    end

    def create 
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def destroy
        instructor = Instructor.find(params[:id])
        instructor.destroy 
        head :no_content
    end

    def create
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :created
      end

   private 

   def record_not_found_message
    render json: {error: "Instructor not found"}, status: :not_found
   end

   def record_invalid_found_message(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
   end
   def instructor_params
    params.permit(:name)
   end

end
