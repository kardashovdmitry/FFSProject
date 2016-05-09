class ReportPdf < Prawn::Document
  def initialize(researchers)
    super()
    @researchers = researchers
    header
    text_content
    table_content
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/logo.png", width: 600, height: 300
  end

  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 50

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 540, :height => 300) do
      text "Report for table Researcher", size: 15, style: :bold
    end



  end

  def table_content
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
    table researcher_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      #self.column_widths = [60, 400, 300]

    end
  end

  def researcher_rows
    [['Name', 'Phone', 'Organizations', 'Address', 'Email']] +
      @researchers.map do |researcher|
      [researcher.name, researcher.phone, researcher.organizations, researcher.address, researcher.email]
    end
  end
end
