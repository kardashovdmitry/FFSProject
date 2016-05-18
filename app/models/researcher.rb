class Researcher < ActiveRecord::Base

    self.primary_key = :researcherID

    has_many :measurement_groups, :class_name => 'MeasurementGroup', :foreign_key => :researcherID

     def self.search(search)
  # Title is for the above case, the OP incorrectly had 'name'
      where("name ILIKE ?", "%#{search}%")
      #where("email ILIKE ?", "%#{search}%")
    end
end
