class AttachmentsController < ApplicationController
 before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @attachments = Attachment.all
  end


  # GET /documents/1
  # GET /documents/1.json
  def show
    send_data(@attachment.file_contents,
              type: @attachment.content_type,
              filename: @attachment.filename)
  end

  # GET /documents/new
  def new
    @attachment = Attachment.new
  end

  def display_graphics
    file_data = params[:file]

    if file_data.respond_to?(:read)
        xml_contents = file_data.read
        spl = xml_contents.split(/\r/)
        ary = Array.new
        spl.each do |i|
        k = i.split(/\n/)
            k.each do |j|
                if j.to_s != ''
                    ary.push(j)
                end
            end
        end

        equal = Array.new
        comma = Array.new

        ary.each do |k|
            if k.include? "="
                equal.push(k.split('='))
            else
                comma.push(k.split(','))

            end
        end

        grades = Hash.new
        equal.each_with_index do |element,index|
            if index == 0
                puts "first"
            else
                #set = element.split(',')
                grades[element[0]] = element[1]

            end
        end


        @dt
        @px
        @py
        @pz
        @repeat
        @duration
        grades.each do |key, value|
              if key.include? "DATA TYPE"
                @dt = value
              elsif key.include? "PinholeX"
                x = value.split
                @px = x[0]
              elsif key.include? "PinholeY"
                y = value.split
                @py = y[0]
              elsif key.include? "PinholeZ"
                z = value.split
                @pz = z[0]
              elsif key.include? "Repeat"
                r = value.split('/')
                @repeat = r[0]
              elsif key.include? "Duration"
                d = value.split('/')
                @duration = d[0]
              end
        end

        @measurement = Measurement.new(:fileName => @dt, :count => @repeat, :binTime => @duration,
            :x => @px, :y => @py, :z => @pz, :C => '0')
        @measurement.save

        forGraph = Hash.new
        forIntns = Hash.new
        comma.each_with_index do |element,index|
            if index == 0 || element[0].to_f == 0.000000
                puts "first"
            else
                if index > 20 and element[1].to_f > 3
                    forIntns[element[0]] = element[1]
                else
                    forGraph[Math.log(element[0].to_f)] = element[1]
                end
            end
        end

        #logger.error "equal : #{grades}"
        #logger.error "forGraph : #{forGraph}"
        #logger.error "forIntns : #{forIntns}"
        @cor = Array.new
        forGraph.each_with_index do |element,index|
            if index != 0
                arr = Array.new
                arr.push(element[0].to_f)
                arr.push(element[1].to_f)
                @cor.push(arr)
            end
        end

        @int = Array.new
        forIntns.each_with_index do |element,index|
            arr = Array.new
            arr.push(element[0].to_f)
            arr.push(element[1].to_f)
            @int.push(arr)
        end
        #redirect_to @measurement, notice: 'Document was successfully created.'

        #redirect_to @measurement
    elsif file_data.respond_to?(:path)
      xml_contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end
  end


  def parse

    file_data = params[:file]

    if file_data.respond_to?(:read)
        xml_contents = file_data.read
        spl = xml_contents.split(/\r/)
        ary = Array.new
        spl.each do |i|
        k = i.split(/\n/)
            k.each do |j|
                if j.to_s != ''
                    ary.push(j)
                end
            end
        end

        equal = Array.new
        comma = Array.new

        ary.each do |k|
            if k.include? "="
                equal.push(k.split('='))
            else
                comma.push(k.split(','))

            end
        end

        grades = Hash.new
        equal.each_with_index do |element,index|
            if index == 0
                puts "first"
            else
                #set = element.split(',')
                grades[element[0]] = element[1]

            end
        end


        @dt
        @px
        @py
        @pz
        @repeat
        @duration
        grades.each do |key, value|
              if key.include? "DATA TYPE"
                @dt = value
              elsif key.include? "PinholeX"
                x = value.split
                @px = x[0]
              elsif key.include? "PinholeY"
                y = value.split
                @py = y[0]
              elsif key.include? "PinholeZ"
                z = value.split
                @pz = z[0]
              elsif key.include? "Repeat"
                r = value.split('/')
                @repeat = r[0]
              elsif key.include? "Duration"
                d = value.split('/')
                @duration = d[0]
              end
        end

        @measurement = Measurement.new(:fileName => @dt, :count => @repeat, :binTime => @duration,
            :x => @px, :y => @py, :z => @pz, :C => '0')
        @measurement.save

        forGraph = Hash.new
        forIntns = Hash.new
        comma.each_with_index do |element,index|
            if index == 0 || element[0].to_f == 0.000000
                puts "first"
            else
                if index > 20 and element[1].to_f > 3
                    forIntns[element[0]] = element[1]
                else
                    forGraph[Math.log(element[0].to_f)] = element[1]
                end
            end
        end

        #logger.error "equal : #{grades}"
        #logger.error "forGraph : #{forGraph}"
        #logger.error "forIntns : #{forIntns}"
        @cor = Array.new
        forGraph.each_with_index do |element,index|
            if index != 0
                arr = Array.new
                arr.push(element[0].to_f)
                arr.push(element[1].to_f)
                @cor.push(arr)
            end
        end

        @int = Array.new
        forIntns.each_with_index do |element,index|
            arr = Array.new
            arr.push(element[0].to_f)
            arr.push(element[1].to_f)
            @int.push(arr)
        end
        redirect_to @measurement, notice: 'Document was successfully created.'

        #redirect_to @measurement
    elsif file_data.respond_to?(:path)
      xml_contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end
  end

  # POST /documents
  # POST /documents.json
  def create
    @attachment = Attachment.new(attachment_params)
    if file_data.respond_to?(:read)
      @@world = file_data.read
      xml_contents = file_data.read
    elsif file_data.respond_to?(:path)
      xml_contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end



    respond_to do |format|
      if @attachment.save
        format.html { redirect_to attachments_path, notice: 'Document was successfully created.' }
        format.json { render action: 'show', status: :created, location: @attachment }
      else
        format.html { render action: 'new' }
        format.json { render json: @dattachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        format.html { redirect_to @attachment, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to attachments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:file)
    end



end
