# encoding: UTF-8
# WSDL4R - WSDL param definition.
# Copyright (C) 2000-2007  NAKAMURA, Hiroshi <nahi@ruby-lang.org>.

# This program is copyrighted free software by NAKAMURA, Hiroshi.  You can
# redistribute it and/or modify it under the same terms of Ruby's license;
# either the dual license version in 2003, or any later version.


require 'wsdl/info'


module WSDL


class Param < Info
  attr_reader :message	# required
  attr_reader :name	# optional but required for fault.
  attr_reader :soapbody
  attr_reader :soapheader
  attr_reader :soapfault

  def initialize
    super
    @message = nil
    @name = nil
    @soapbody = nil
    @soapheader = []
    @soapfault = nil
  end

  def targetnamespace
    parent.targetnamespace
  end

  def find_message
    root.message(@message) or raise RuntimeError.new("#{@message} not found")
  end

  def soapbody_use
    if @soapbody
      @soapbody.use || :literal
    else
      nil
    end
  end

  def soapbody_encodingstyle
    if @soapbody
      @soapbody.encodingstyle
    else
      nil
    end
  end

  def parse_element(element)
    case element
    when SOAPBodyName, SOAP12BodyName
      o = WSDL::SOAP::Body.new
      @soapbody = o
      o
    when SOAPHeaderName, SOAP12HeaderName
      o = WSDL::SOAP::Header.new
      @soapheader << o
      o
    when SOAPFaultName, SOAP12FaultName
      o = WSDL::SOAP::Fault.new
      @soapfault = o
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
    when MessageAttrName
      if value.namespace.nil?
        value = XSD::QName.new(targetnamespace, value.source)
      end
      @message = value
    when NameAttrName
      @name = XSD::QName.new(targetnamespace, value.source)
    else
      nil
    end
  end
end


end
