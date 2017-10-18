class SubjectsController < ApplicationController

  load_and_authorize_resource

  def index
    @subjects = Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
  end

  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        @subject = Subject.new(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to subjects_path, notice: 'subject was successfully updated.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_path, notice: 'subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def subject_params
    params.require(:subject).permit(
    :name, 
    school_class_subjects_attributes: :school_class_id
    )
  end
end
