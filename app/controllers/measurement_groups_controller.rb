class MeasurementGroupsController < ApplicationController

  def index
    @measurement_groups = MeasurementGroup.all

  end

  def new
    @measurement_group = MeasurementGroup.new
    @researcher = Researcher.all
    @sample = Sample.all
    @device = Device.all
  end

  def edit
  @measurement_group = MeasurementGroup.find(params[:id])
  end

  def show
    @measurement_group = MeasurementGroup.find(params[:id])
    if @measurement_group.researcherID != nil
      @researcher = Researcher.find(@measurement_group.researcherID)
    end
    if @measurement_group.deviceID != nil
      @device = Device.find(@measurement_group.deviceID)
    end
    if @measurement_group.sampleID != nil
      @sample = Sample.find(@measurement_group.sampleID)
    end
  end

  def create
    @measurement_group = MeasurementGroup.new(measurement_group_params)

    if @measurement_group.save
    redirect_to @measurement_group
    else
    render 'new'
    end
  end

  def update
  @measurement_group = MeasurementGroup.find(params[:id])

  if @measurement_group.update(measurement_group_params)
    redirect_to @measurement_group
  else
    render 'edit'
  end
  end

  def destroy
  @measurement_group = MeasurementGroup.find(params[:id])
  @measurement_group.destroy

  redirect_to measurement_groups_path
end



  private
  def measurement_group_params
    params.require(:measurement_group).permit(:sampleID, :researcherID, :deviceID, :name, :date)
  end
end


