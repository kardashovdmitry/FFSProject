class ReportSample < Prawn::Document
  def initialize(sample)
    super()
    @sample = sample
    header
    text_content
    table_content
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/logoPdf.png", width: 150, height: 150
  end

  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 50

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 300, :height => 50) do
      text "Report for table Sample", size: 15, style: :bold
    end



  end

  def table_content
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
    font_families.update(
    "DejaVuSans" => {
      :normal => "app/reports/DejaVuSans.ttf",
      :bold => "app/reports/DejaVuSans-Bold.ttf",
      :italic => "app/reports/DejaVuSans-Oblique.ttf",
      :bold_italic => "app/reports/DejaVuSans-BoldOblique",
    }
  )
  fallback_fonts(["DejaVuSans"])

    table researcher_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      #self.column_widths = [60, 400, 300]

    end
  end

  def researcher_rows
    [['Name', 'Weight', 'Size', 'M', 'Lambda em', 'Lambda ex', 'Description']] +
      @sample.map do |researcher|
      [researcher.name, researcher.weight, researcher.size, researcher.M, researcher.lambda_em,
        researcher.lambda_ex, researcher.description]
    end
  end
end
