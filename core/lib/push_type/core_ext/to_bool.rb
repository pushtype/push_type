class String
  def to_bool
    self.blank? || self.match(/^(false|no|0)$/i) ? false : true
  end
end

(defined?(Integer) ? Integer : Fixnum).class_eval do
  def to_bool
    !self.zero?
  end
end

class TrueClass
  def to_i; 1; end
  def to_bool; self; end
end

class FalseClass
  def to_i; 0; end
  def to_bool; self; end
end

class NilClass
  def to_bool; false; end
end
