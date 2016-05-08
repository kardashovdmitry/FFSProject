class DescriptionForMeasurementGroup < ActiveRecord::Base

    self.primary_key = :DescriptionForMeasurementGroupID

    belongs_to :measurement_group, :class_name => 'MeasurementGroup', :foreign_key => :groupID
end
