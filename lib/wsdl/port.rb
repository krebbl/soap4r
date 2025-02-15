# encoding: UTF-8
# WSDL4R - WSDL port definition.
# Copyright (C) 2000-2007  NAKAMURA, Hiroshi <nahi@ruby-lang.org>.

# This program is copyrighted free software by NAKAMURA, Hiroshi.  You can
# redistribute it and/or modify it under the same terms of Ruby's license;
# either the dual license version in 2003, or any later version.


require 'wsdl/info'


module WSDL


class Port < Info
  attr_reader :name		# required
  attr_reader :binding		# required
  attr_reader :soap_address

  def initialize
    super
    @name = nil
    @binding = nil
    @soap_address = nil
  end

  def targetnamespace
    parent.targetnamespace
  end

  def porttype
    root.porttype(find_binding.type)
  end

  def find_binding
    root.binding(@binding) or raise RuntimeError.new("#{@binding} not found")
  end

  def parse_element(element)
    case element
    when SOAPAddressName, SOAP12AddressName
      o = WSDL::SOAP::Address.new
      @soap_address = o
      o
    when DocumentationName
      o = Documentation.new
      o
    else
      nil
    end
  end

  def parse_attr(attr, value)
    case attr
    when NameAttrName
      @name = XSD::QName.new(targetnamespace, value.source)
    when BindingAttrName
      @binding = value
    else
      nil
    end
  end
end


end
