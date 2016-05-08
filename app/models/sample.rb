class Sample < ActiveRecord::Base

    self.primary_key = :sampleID

    has_many :measurement_groups, :class_name => 'MeasurementGroup', :foreign_key => :sampleID
end
