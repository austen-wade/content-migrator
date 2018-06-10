require 'Nokogiri'

class XMLF
	def initialize(file, output)
		@file = file
		@doc = File.open(file) { |f| Nokogiri::XML(f) }
		@output = output
	end

	def set_node_attribute(node_xpath, attribute, new_value, index = nil)
		p node_xpath
		p attribute
		p new_value
		node_set = @doc.xpath(node_xpath)

		if index.nil?
			for node in node_set
				p node
				node[attribute] = new_value
			end

		else
			node_set[index][attribute] = new_value
		end
	end

	def rename_node(node_xpath, new_name, index = nil)
		node_set = @doc.xpath(node_xpath)

		if index.nil?
			for node in node_set
				node.name = new_name
			end

		else
			node_set[index].name = new_name
		end
	end

	def rename_node_attribute(node_xpath, attribute, new_name, index = nil)
		node_set = @doc.xpath("#{node_xpath}[@#{attribute}]")

		if index.nil?
			for node in node_set
				node[new_name] = node[attribute]
				node.delete(attribute)
			end

		else
			node_set[index][new_name] = node_set[index][attribute]
			node_set[index].delete(attribute)
		end
	end

	def remove_node_attribute(node_xpath, attribute, index = nil);
		node_set = @doc.xpath("#{node_xpath}[@#{attribute}]")

		if index.nil?
			for node in node_set
				node.delete(attribute)
			end

		else
			node_set[index].delete(attribute)
		end
	end

	def delete_node(node_xpath, index = nil)
		node_set = @doc.xpath(node_xpath)

		if index.nil?
			for node in node_set
				node.remove
			end

		else
			node_set[index].remove
		end
	end

	def replace_node(node_xpath, new_node, index= nil)
		node_set = @doc.xpath(node_xpath)

		if index.nil?
			for node in node_set
				node.replace(new_node)
			end

		else
			node_set[index].replace(new_node)
		end
	end

	def set_output(filename)
		@output = File.open(filename)
	end

	def write
		File.write(@output, @doc.to_xml)
	end
end
