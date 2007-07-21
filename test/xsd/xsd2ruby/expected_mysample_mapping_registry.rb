require 'xsd/mapping'
require 'mysample.rb'

module XSD; module XSD2Ruby

module MysampleMappingRegistry
  NsMysample = "urn:mysample"
  Registry = ::SOAP::Mapping::LiteralRegistry.new

  Registry.register(
    :class => XSD::XSD2Ruby::Question,
    :schema_ns => NsMysample,
    :schema_type => "question",
    :schema_qualified => false,
    :schema_element => [
      ["something", ["SOAP::SOAPString", XSD::QName.new(nil, "something")]]
    ]
  )

  Registry.register(
    :class => XSD::XSD2Ruby::Section,
    :schema_ns => NsMysample,
    :schema_type => "section",
    :schema_qualified => false,
    :schema_element => [
      ["sectionID", ["SOAP::SOAPInt", XSD::QName.new(nil, "sectionID")]],
      ["name", ["SOAP::SOAPString", XSD::QName.new(nil, "name")]],
      ["description", ["SOAP::SOAPString", XSD::QName.new(nil, "description")]],
      ["index", ["SOAP::SOAPInt", XSD::QName.new(nil, "index")]],
      ["firstQuestion", ["XSD::XSD2Ruby::Question", XSD::QName.new(nil, "firstQuestion")]]
    ]
  )

  Registry.register(
    :class => XSD::XSD2Ruby::SectionArray,
    :schema_ns => NsMysample,
    :schema_type => "sectionArray",
    :schema_element => [
      ["element", ["XSD::XSD2Ruby::Section[]", XSD::QName.new(nil, "element")], [1, nil]]
    ]
  )

  Registry.register(
    :class => XSD::XSD2Ruby::SectionElement,
    :schema_ns => NsMysample,
    :schema_name => "sectionElement",
    :schema_qualified => true,
    :schema_element => [
      ["sectionID", ["SOAP::SOAPInt", XSD::QName.new(nil, "sectionID")]],
      ["name", ["SOAP::SOAPString", XSD::QName.new(nil, "name")]],
      ["description", ["SOAP::SOAPString", XSD::QName.new(nil, "description")]],
      ["index", ["SOAP::SOAPInt", XSD::QName.new(nil, "index")]],
      ["firstQuestion", ["XSD::XSD2Ruby::Question", XSD::QName.new(nil, "firstQuestion")]]
    ]
  )
end

end; end