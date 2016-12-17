module Airmodel
  class Model

    # iterate through all the many ways TFPID might be
    # fucking defined on this thing, return the first one that works
    def goddamn_tfpid
      keys = [self["TFPID"], self[:tfpid], self[:TFPID], self["tfpid"], self['id']]
      keys.find{|u| !u.blank? }
    end

    # iterate through all the many ways CITY_ID might be
    # fucking defined on this thing, return the first one that works
    def goddamn_city
      keys = [self["CITY_TFPID"], self[:city_tfpid], self[:CITY_TFPID], self["city_tfpid"]]
      keys.find{|u| !u.blank? }
    end

    # iterate through all the many ways SCHOOL_ID might be
    # fucking defined on this thing, return the first one that works
    def goddamn_school
      keys = [self["SCHOOL_TFPID"], self[:school_tfpid], self[:SCHOOL_TFPID], self["school_tfpid"]]
      keys.find{|u| !u.blank? }
    end

    def cache_key
      "#{self.class.table_name}_#{goddamn_tfpid}"
    end

  end

end
