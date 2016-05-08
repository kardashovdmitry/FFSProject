class ResearchersController < ApplicationController
  def index
    @researchers = Researcher.all

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReportPdf.new(@researchers)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end

  end

  def new
    @researcher = Researcher.new
  end

  def edit
  @researcher = Researcher.find(params[:id])
  end

  def show
    @researcher = Researcher.find(params[:id])
  end

  def create
    @researcher = Researcher.new(researcher_params)

    if @researcher.save
    redirect_to @researcher
    else
    render 'new'
    end
  end

  def update
  @researcher = Researcher.find(params[:id])

  if @researcher.update(researcher_params)
    redirect_to @researcher
  else
    render 'edit'
  end
  end

  def destroy
  @researcher = Researcher.find(params[:id])
  @researcher.destroy

  redirect_to researchers_path
end



  private
  def researcher_params
    params.require(:researcher).permit(:name, :phone, :organizations, :address, :email)
  end

end

