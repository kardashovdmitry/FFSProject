class Sample < ActiveRecord::Base

    self.primary_key = :sampleID

    has_many :measurement_groups, :class_name => 'MeasurementGroup', :foreign_key => :sampleID

    def self.search(search)
  # Title is for the above case, the OP incorrectly had 'name'
      where('"name" ILIKE ?', "%#{search}%")
    end

end
