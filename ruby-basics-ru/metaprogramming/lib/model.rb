# frozen_string_literal: true
require 'date'
# BEGIN
module Model
  def self.included(base)
    base.extend self
  end

  def attribute(name, options = {})
    define_method(name) do
      val = @attributes[name]

      if @attributes.key?(name) && val.nil?
        nil
      elsif val.nil?
        options[:default].nil? ? nil : options[:default]
      else
        case options[:type]
        when :integer, :Integer then val.to_i
        when :float, :Float then val.to_f
        when :boolean, :Boolean then val.to_s.downcase == 'true'
        when :datetime, :DateTime then DateTime.parse(val)
        else val
        end
      end
    end

    define_method("#{name}=") do |val|
      @attributes[name] = val
    end
  end

  def initialize(attributes = {})
    @attributes = attributes
  end

  def attributes
    attributes = default_attr.merge(@attributes)
    attributes.each_with_object({}) { |(key, val), acc| acc[key] = send(key) }
  end

  protected
  def default_attr
    default ||= {}

    self.class.instance_methods(false).each do | method_name |
      key = method_name.to_s.to_sym
      unless method_name.end_with?('=')
        default[key] ||= {}
      end
    end

    default
  end
end
# END
