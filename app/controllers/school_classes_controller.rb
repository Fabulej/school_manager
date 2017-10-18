class SchoolClassesController < ApplicationController

  load_and_authorize_resource

  def index
    @school_classes = SchoolClass.all
  end

  def show
    @school_class = SchoolClass.find(params[:id])
  end

  def new
    @school_class = SchoolClass.new
    @school_class.subjects.build
  end

  def create
    @school_class = SchoolClass.new(school_class_params)

    respond_to do |format|
      if @school_class.save
        subjects_ids = params.dig(:subjects, :id) || []
        students_ids = params.dig(:students, :id) || []
        @school_class.update(subject_ids: subjects_ids)
        @school_class.update(student_ids: students_ids)
        format.html { redirect_to @school_class, notice: 'School class was successfully created.' }
        format.json { render :show, status: :created, location: @school_class }
      else
        format.html { render :new }
        format.json { render json: @school_class.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @school_class.update(school_class_params)
        add_students_and_subjects(@school_class)
        format.html { redirect_to @school_class, notice: 'School class was successfully updated.' }
        format.json { render :show, status: :ok, location: @school_class }
      else
        format.html { render :edit }
        format.json { render json: @school_class.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @school_class.destroy
    respond_to do |format|
      format.html { redirect_to school_classes_url, notice: 'School class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def add_students_and_subjects(school_class)
    new_subjects_ids = params.dig(:subjects, :id)&.map(&:to_i) || []
    new_students_ids = params.dig(:students, :id)&.map(&:to_i) || []
    subjects_ids = school_class.subject_ids + new_subjects_ids
    students_ids = school_class.student_ids + new_students_ids
    school_class.update(subject_ids: subjects_ids)
    school_class.update(student_ids: students_ids)
  end

  def school_class_params
    params.require(:school_class).permit(:name)
  end
end
