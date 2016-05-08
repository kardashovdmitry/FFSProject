class Linked < ActiveRecord::Base



    belongs_to :measurement, :class_name => 'Measurement', :foreign_key => :measurementID
    belongs_to :measurement_group, :class_name => 'MeasurementGroup', :foreign_key => :groupID
end
