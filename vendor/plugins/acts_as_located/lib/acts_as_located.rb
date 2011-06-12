module ActsAsLocated
  def acts_as_located
    has_one :location, :as => :locatable, :dependent => :destroy

    accepts_nested_attributes_for :location, :allow_destroy => true

    include InstanceMethods
  end

  module InstanceMethods
    def initialize(attributes = nil)

      # build location for form
      # self.locations.build

      super(attributes)
    end

    def locatable?
      true
    end
  end
end
ActiveRecord::Base.extend ActsAsLocated