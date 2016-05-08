class RawDatum < ActiveRecord::Base

    self.primary_key = :rdID

    has_many :measurements, :class_name => 'Measurement'
    has_many :description_for_rds, :class_name => 'DescriptionForRd', :foreign_key => :rdID
    belongs_to :measurement_group, :class_name => 'MeasurementGroup', :foreign_key => :groupID
end
