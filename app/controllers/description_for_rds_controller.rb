class DescriptionForRdsController < ApplicationController
  def index
    @descriptionForRds = DescriptionForRd.all
  end

  def new
    @descriptionForRd = DescriptionForRd.new
  end

  def edit
  @descriptionForRd = DescriptionForRd.find(params[:id])
  end

  def show
    @descriptionForRd = DescriptionForRd.find(params[:id])
  end

  def create
    @descriptionForRd = DescriptionForRd.new(description_for_rd_params)

    if @descriptionForRd.save
    redirect_to @descriptionForRd
    else
    render 'new'
    end
  end

  def update
  @descriptionForRd = DescriptionForRd.find(params[:id])

  if @descriptionForRd.update(description_for_rd_params)
    redirect_to @descriptionForRd
  else
    render 'edit'
  end
  end

  def destroy
  @descriptionForRd = DescriptionForRd.find(params[:id])
  @descriptionForRd.destroy

  redirect_to devices_path
end



  private
  def description_for_rd_params
    params.require(:description_for_rd).permit(:name, :value, :rdId)
  end
end
