require_relative 'xmlf'

$target = ARGV[0]
$input = ARGV[1]


# if there's no input of data
if $input.nil?
	if File.file?($target)
		xmlf = XMLF.new($target)
		# code goes here

		#
		xmlf.write;

	elsif File.directory?($target)
		Dir.glob('*/**/*.xml') do |xml_file|
			xmlf = XMLF.new(xml_file)
			# code goes here

			#
			xmlf.write;
		end
	end

# if there's an input of data
else
	if File.file?($target)
		xmlf = XMLF.new($target)
		# code goes here
			
		#
		xmlf.write;

	elsif File.directory?($target)
		Dir.glob('*/**/*.xml') do |xml_file|
			xmlf = XMLF.new(xml_file)
			# code goes here
			
			#
			xmlf.write;
		end
	end
end
