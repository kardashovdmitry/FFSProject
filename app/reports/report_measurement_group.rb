class ReportMeasurementGroup < Prawn::Document
  def initialize(measurements)
    super()
    @measurementGroup = measurements
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
      text "Report for table Measurement Group", size: 15, style: :bold
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
    [['Name', 'Date', 'Sample', 'Researcher', 'Device']] +
      @measurementGroup.map do |researcher|
        @researcher = Researcher.new;
        @researcher.name = '';
        @device = Device.new;
        @device.name = '';
        @sample = Sample.new;
        @sample.name = '';
        if researcher.researcherID != nil
          @researcher = Researcher.find(researcher.researcherID)
        end
        if researcher.deviceID != nil
          @device = Device.find(researcher.deviceID)
        end
        if researcher.sampleID != nil
          @sample = Sample.find(researcher.sampleID)
        end
      [researcher.name, researcher.date, @researcher.name, @device.name, @sample.name]
    end
  end
end
