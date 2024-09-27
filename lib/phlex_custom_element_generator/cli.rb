require "json"
require "rainbow" # <- optional, for color support
require "fmt"
require "prompts"
require "thor"

## Cases to handle
# from HTTP
# from a bare namespace, look up node_modules
# from a full path

module PhlexCustomElementGenerator
  class CLI < Thor
    # include Thor::Actions

    def self.exit_on_failure?
      true
    end

    # def self.source_root
    #   File.dirname(__FILE__)
    # end

    desc "generate_components [manifest_path] [options]", "Generates new Phlex components from a given `custom-elements.json`"
    def generate_components(manifest_path = "", directory = "", namespaces = ["Shoelace"])
      if manifest_path.to_s.chomp.strip == ""
        manifest_path = Prompts::TextPrompt.ask(
          label: "What is the file path of your custom elements manifest?",
          hint: "IE: node_modules/@shoelace-style/shoelace/dist/custom-elements.json",
          required: true
        )
      end

      ManifestReader.new(manifest: manifest_path).list_tag_names.each do |tag_name|
        class_name = tag_name.split(/-/).map(&:capitalize)
        component = ComponentGenerator.new(class_name: class_name, tag_name: tag_name, namespaces: namespaces)
        puts "Writing to: #{tag_name} to #{directory}"
        File.write(directory, component.create)
      end
    end

    desc "print_tag_names [manifest_path] [options]", "Prints a list of all elements from a manifest with original casing"
    def print_tag_names(manifest_path = "")
      puts ManifestReader.new(manifest: manifest_path).list_tag_names
    end

    desc "print_phlex_registrations [manifest_path] [options]", "Prints a list of all elements from a manifest with kebab-case turned into snake_case"
    def print_phlex_registrations(manifest_path = "")
      if manifest_path.to_s.chomp.strip == ""
        manifest_path = Prompts::TextPrompt.ask(
          label: "What is the file path of your custom elements manifest?",
          hint: "IE: node_modules/@shoelace-style/shoelace/dist/custom-elements.json",
          required: true
        )
      end
      puts ManifestReader.new(manifest: manifest_path).list_tag_names.map { |tag_name| "register_element :" + tag_name.gsub(/-/, "_") }
    end
  end
end
