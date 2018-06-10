require_relative 'xmlf'

$input = ARGV[0]
$target = ARGV[1]
$output_file = ARGV[2]

p $target
p $input
p $output_file

# if there's no input of data
if $input.nil?
	if File.file?($target)
		xmlf = XMLF.new($target, $output_file)
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
		xmlf = XMLF.new($target, $output_file)
		config_file = File.open($input) { |f| Nokogiri::XML(f) }

		##########
		# Rename Node
		rename_nodes_sets = config_file.xpath('//renameNodes/set')
		rename_nodes_sets.each do |set|
			xmlf.rename_node(set.xpath('xpath').text, set.xpath('newName').text)
		end

		# Delete Node
		delete_nodes_sets = config_file.xpath('//deleteNodes/set')
		delete_nodes_sets.each do |set|
			xmlf.delete_node(set.xpath('xpath').text);
		end

		# Replace Nodes
		# replace_nodes_sets = config_file.xpath('//replaceNodes/set')
		# replace_nodes_sets.each do |set|
		# 	p set.xpath('xpath').text
		# 	p set.xpath('newNode').text
		# end

		# Rename Node Attributes
		rename_node_attributes_sets = config_file.xpath('//renameNodeAttributes/set')
		rename_node_attributes_sets.each do |set|
			xmlf.rename_node_attribute(set.xpath('xpath').text, set.xpath('attribute').text, set.xpath('newAttributeName').text)
		end

		# Set Node Attribute
		set_node_attributes_sets = config_file.xpath('//setNodeAttributes/set')
		set_node_attributes_sets.each do |set|
			xmlf.set_node_attribute(set.xpath('xpath').text, set.xpath('attribute').text, set.xpath('newValue').text)
		end

		# Remove Node Attributes
		remove_node_attributes_sets = config_file.xpath('//removeNodeAttributes/set')
		remove_node_attributes_sets.each do |set|
			xmlf.remove_node_attribute(set.xpath('xpath').text, set.xpath('attribute').text)
		end
		##########

		xmlf.write;

		elsif File.directory?($target)
			Dir.glob('*/**/*.xml') do |xml_file|
			xmlf = XMLF.new(xml_file)
			# code goes here
			config_file = File.open($input) { |f| Nokogiri::XML(f) }

			##########
			# Rename Node
			rename_nodes_sets = config_file.xpath('//renameNodes/set')
			rename_nodes_sets.each do |set|
				xmlf.rename_node(set.xpath('xpath').text, set.xpath('newName').text)
			end

			# Delete Node
			delete_nodes_sets = config_file.xpath('//deleteNodes/set')
			delete_nodes_sets.each do |set|
				xmlf.delete_node(set.xpath('xpath').text);
			end

			# Replace Nodes
			# replace_nodes_sets = config_file.xpath('//replaceNodes/set')
			# replace_nodes_sets.each do |set|
			# 	p set.xpath('xpath').text
			# 	p set.xpath('newNode').text
			# end

			# Rename Node Attributes
			rename_node_attributes_sets = config_file.xpath('//renameNodeAttributes/set')
			rename_node_attributes_sets.each do |set|
				xmlf.rename_node_attribute(set.xpath('xpath').text, set.xpath('attribute').text, set.xpath('newAttributeName').text)
			end

			# Set Node Attribute
			set_node_attributes_sets = config_file.xpath('//setNodeAttributes/set')
			set_node_attributes_sets.each do |set|
				xmlf.set_node_attribute(set.xpath('xpath').text, set.xpath('attribute').text, set.xpath('newValue').text)
			end

			# Remove Node Attributes
			remove_node_attributes_sets = config_file.xpath('//removeNodeAttributes/set')
			remove_node_attributes_sets.each do |set|
				xmlf.remove_node_attribute(set.xpath('xpath').text, set.xpath('attribute').text)
			end
			##########

			xmlf.write;
		end
	end
end
