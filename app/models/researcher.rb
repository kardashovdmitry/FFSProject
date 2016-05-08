class Researcher < ActiveRecord::Base

    self.primary_key = :researcherID

    has_many :measurement_groups, :class_name => 'MeasurementGroup', :foreign_key => :researcherID
end
