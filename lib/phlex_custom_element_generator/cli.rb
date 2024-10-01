require "json"
require 'fileutils'
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
    method_option :directory, type: :string, aliases: "d", default: "", banner: "The directory to place your components based on the current working directory."
    method_option :namespaces, type: :string, aliases: "n", default: "", banner: "The module namespaces to place your component in IE: module Shoelace. This option is case-sensitive."
    def generate_components(manifest_path = "")
      if manifest_path.to_s.chomp.strip == ""
        manifest_path = Prompts::TextPrompt.ask(
          label: "What is the file path of your custom elements manifest?",
          hint: "IE: ./node_modules/@shoelace-style/shoelace/dist/custom-elements.json",
          required: true
        )
      end

      directory = options[:directory]
      if directory.to_s.chomp.strip == ""
        directory = Prompts::TextPrompt.ask(
          label: "What directory should we place your components in?",
          hint: "IE: ./shoelace. Hit [Enter] to place them in the current directory.",
        )
      end

      directory = directory.to_s.chomp.strip
      if directory == ""
        directory = "."
      end
      FileUtils.mkdir_p(directory)


      namespaces = options[:namespaces]
      if namespaces.to_s.chomp.strip == ""
        namespaces = Prompts::TextPrompt.ask(
          label: "What namespaces should we place your components in? List should be comma separated.",
          hint: "IE: Views,Shoelace . Hit [Enter] to place them with no namespace.",
        )
      end

      namespaces = namespaces.split(/\s*,\s*/).reject { |str| str.to_s.chomp == "" }

      ManifestReader.new(manifest: manifest_path).list_tag_names.each do |tag_name|
        class_name = tag_name.split(/-/).map(&:capitalize).join("")
        component = ComponentGenerator.new(class_name: class_name, tag_name: tag_name, namespaces: namespaces)
        file_path = File.join(directory, tag_name.gsub(/-/, "_") + ".rb")
        puts "Writing to: #{tag_name} to #{file_path}"
        File.write(file_path, component.create)
      end
    end

    desc "print_tag_names [manifest_path]", "Prints a list of all elements from a manifest with original casing"
    def print_tag_names(manifest_path = "")
      if manifest_path.to_s.chomp.strip == ""
        manifest_path = Prompts::TextPrompt.ask(
          label: "What is the file path of your custom elements manifest?",
          hint: "IE: node_modules/@shoelace-style/shoelace/dist/custom-elements.json",
          required: true
        )
      end

      puts ManifestReader.new(manifest: manifest_path).list_tag_names
    end

    desc "print_phlex_registrations [manifest_path]", "Prints a list of all elements from a manifest with kebab-case turned into snake_case"
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
