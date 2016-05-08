class DescriptionForRd < ActiveRecord::Base
    self.table_name = 'description_for_rd'
    self.primary_key = :DescriptionForRdID

    belongs_to :raw_datum, :class_name => 'RawDatum', :foreign_key => :rdID
end
