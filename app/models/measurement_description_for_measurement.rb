class MeasurementDescriptionForMeasurement < ActiveRecord::Base

    self.primary_key = :DescriptionForMeasurementID

    belongs_to :measurement, :class_name => 'Measurement', :foreign_key => :measurementID
end
