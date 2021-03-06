include Geokit::Geocoders

class Location < ActiveRecord::Base
  belongs_to :locatable, :polymorphic => true

  before_save :geolocate_from_address

  def geolocate_from_address

    # check if address has changed
    if self.address_changed?
      # check if an actual address has been set
      if self.address.to_s.strip.size > 0
        # find information related to address
        res = GoogleGeocoder.geocode(self.address.z_fix_charset)

        # save related fields
        if(res)
          self.city = res.city
          self.county = res.province
          self.country_code = res.country_code
          self.region = res.state
          self.zipcode = res.zip
          self.street = res.street_address
          self.latitude = res.lat
          self.longitude = res.lng
        else
          # address not found
          self.city = nil
          self.county = nil
          self.country_code = nil
          self.region = nil
          self.zipcode = nil
          self.street = nil
          self.latitude = nil
          self.longitude = nil
        end
      end
    end
  end
end
