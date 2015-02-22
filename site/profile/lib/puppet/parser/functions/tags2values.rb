Puppet::Parser::Functions.newfunction(:tags2values,
    :type  => :rvalue,
    :arity => 2,
    :doc   => 'transforms a hash of aws tags into a hash of hashes for create_resources(route53_txt_record, $zone)'
  ) do |args|
  tags = args[0]
  zone = args[1]
  raise ArgumentError, "Expects a hash" unless tags.class == Hash
  raise ArgumentError, "Expects a string" unless zone.class == String

  response = {}
  tags.each do |k,v|
    response["#{k}.#{zone}"] = { 'values' => v }
  end

  response
end
