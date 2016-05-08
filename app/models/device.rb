class Device < ActiveRecord::Base

    self.primary_key = :deviceID

    has_many :measurement_groups, :class_name => 'MeasurementGroup', :foreign_key => :deviceID
end
