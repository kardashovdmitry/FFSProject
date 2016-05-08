class RawDatumsController < ApplicationController

  def index
    @raw_datums = RawDatum.all

  end

  def new
    @raw_datum = RawDatum.new
  end

  def edit
  @raw_datum = RawDatum.find(params[:id])
  end

  def show
    @raw_datum = RawDatum.find(params[:id])
  end

  def create
    @raw_datum = RawDatum.new(raw_datum_params)

    if @raw_datum.save
    redirect_to @raw_datum
    else
    render 'new'
    end
  end

  def update
  @raw_datum = RawDatum.find(params[:id])

  if @raw_datum.update(raw_datum_params)
    redirect_to @raw_datum
  else
    render 'edit'
  end
  end

  def destroy
  @raw_datum = RawDatum.find(params[:id])
  @raw_datum.destroy

  redirect_to raw_datums_path
end



  private
  def raw_datum_params
    params.require(:raw_datum).permit(:groupID, :FileName, :linkToFile, :startTime, :repetitionNumber, :kineticsNumber, :description)
  end
end


