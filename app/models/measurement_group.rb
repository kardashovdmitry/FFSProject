class MeasurementGroup < ActiveRecord::Base

    self.primary_key = :groupID

    has_many :linkeds, :class_name => 'Linked', :foreign_key => :groupID
    has_many :description_for_measurement_groups, :class_name => 'DescriptionForMeasurementGroup', :foreign_key => :groupID
    belongs_to :sample, :class_name => 'Sample', :foreign_key => :sampleID
    belongs_to :researcher, :class_name => 'Researcher', :foreign_key => :researcherID
    belongs_to :device, :class_name => 'Device', :foreign_key => :deviceID
    has_many :raw_data, :class_name => 'RawDatum', :foreign_key => :groupID
end
