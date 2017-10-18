class GradesController < ApplicationController

  load_and_authorize_resource

  before_action :set_grade, only: [:show, :edit]

  def index
  end

  def history
    @versions = PaperTrail::Version.order('created_at DESC')
  end

  def generate
    CsvGeneratorJob.perform_later(current_user.id)
    redirect_to subject_path(current_user.subject.id)
  end

  def download_csv
    send_file(
      "#{Rails.root}/public/file.csv",
      filename: "summary.csv",
      type: "application/csv"
    )
  end

  def show
  end

  def new
  end

  def create
    @grade = Grade.new(grade_params)
    respond_to do |format|
      if @grade.save
        GradeNotificationMailer.notify_user(@grade).deliver_now
        @grade = Grade.new(grade_params)
        format.html { redirect_to subject_path(current_user.subject.id), notice: 'Grade was successfully created.' }
        format.json { render :show, status: :created, location: @grade }
      else
        format.html { render :new }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @grade.update(grade_params)
        GradeNotificationMailer.notify_user(@grade).deliver_now
        format.html { redirect_to subject_path(current_user.subject.id), notice: 'Grade was successfully updated.' }
        format.json { render :show, status: :created, location: @grade }
      else
        format.html { render :new }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to subject_path(current_user.subject.id), notice: 'Grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_grade
    @grade = Grade.find(params[:id])
  end

  def grade_params
    params.require(:grade).permit(
      :value, :description, :subject_id, :user_id
    )
  end
end
