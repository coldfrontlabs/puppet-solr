#
# other_files.rb
#
# newfunction(:other_files, :type => :rvalue, :doc => "Returns file resources to be deployed to solr cores.") do |arguments|

module Puppet::Parser::Functions
  newfunction(:other_files, type: :rvalue, doc: 'Returns file resources to be deployed to solr cores.') do |arguments|
    raise(Puppet::ParseError, "other_files(): Wrong number of arguments given (#{arguments.size} for 2)") if arguments.size < 2

    files = arguments[0]
    conf_dir = arguments[1]
    raise(Puppet::ParseError, "other_files(): Wrong type given (#{files.class})") if files.class != Array

    file_resources = {}

    files.each do |v|
      file_resources["#{conf_dir}/#{File.basename(v)}"] = { 'source' => v }
    end

    return file_resources
  end
end
