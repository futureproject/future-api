class Hash
  # Returns a hash that removes any matches with the other hash
  #
  # {a: {b:"c"}} - {:a=>{:b=>"c"}}                   # => {}
  # {a: [{c:"d"},{b:"c"}]} - {:a => [{c:"d"}, {b:"d"}]} # => {:a=>[{:b=>"c"}]}
  #
  def diff!(other_hash)
    other_hash.each_pair do |k,v|
      tv = self[k]
      if tv.is_a?(Hash) && v.is_a?(Hash) && v.present? && tv.present?
        tv.diff!(v)
      elsif v.is_a?(Array) && tv.is_a?(Array) && v.present? && tv.present?
        v.each_with_index do |x, i| 
          tv[i].diff!(x)
        end
        self[k] = tv - [{}]
      else
        self.delete(k) if self.has_key?(k) && tv == v
      end
      self.delete(k) if self.has_key?(k) && self[k].blank?
    end
    self
  end

  def diff(other_hash)
    dup.diff!(other_hash)
  end

  def -(other_hash)
    self.diff(other_hash)
  end
end
