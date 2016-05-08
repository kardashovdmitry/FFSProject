class Measurement < ActiveRecord::Base

    self.primary_key = :measurementID

    has_many :linkeds, :class_name => 'Linked', :foreign_key => :measurementID
    belongs_to :raw_datum, :class_name => 'RawDatum', :foreign_key => :rpID
    has_many :measurement_description_for_measurements, :class_name => 'MeasurementDescriptionForMeasurement', :foreign_key => :measurementID
end
