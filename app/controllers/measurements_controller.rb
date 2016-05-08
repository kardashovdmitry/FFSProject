class MeasurementsController < ApplicationController

  def index
    @measurements = Measurement.all
  end

  def new
    @measurement = Measurement.new
  end

  def edit
  @measurement = Measurement.find(params[:id])
  end

  def show
    @measurement = Measurement.find(params[:id])
  end

  def create
    @measurement = Measurement.new(measurement_params)

    if @measurement.save
    redirect_to @measurement
    else
    render 'new'
    end
  end

  def update
  @measurement = Measurement.find(params[:id])

  if @measurement.update(measurement_params)
    redirect_to @measurement
  else
    render 'edit'
  end
  end

  def destroy
  @measurement = Measurement.find(params[:id])
  @measurement.destroy

  redirect_to measurements_path
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
        #redirect_to @measurement, notice: 'Document was successfully created.'

        #redirect_to @measurement
    elsif file_data.respond_to?(:path)
      xml_contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end
  end

  private
  def measurement_params
    params.require(:measurement).permit(:fileName, :count, :binTime, :T, :C, :n,
                                                        :rpID, :x, :y, :z, :std)

end

def file_params
    params.require(:measurement).permit(:file)

end





end
