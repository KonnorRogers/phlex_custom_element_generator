require "json"

module PhlexCustomElementGenerator
  class ManifestReader
    attr_accessor :manifest, :manifest_json

    # Reads a given string and determins if it should fetch over HTTP, Read a file, or read the contents.
    def read_manifest(str)
      # return read_manifest_from_http(str) if str =~ /^https?:\/\//

      return JSON.parse(File.read(str)) if File.exist?(str)

      # Try finding it in node_modules?
      # return read_from_node_modules(str)

      # Fallback to the string and hope its valid JSON
      JSON.parse(str)
    end

    def initialize(manifest:)
      @manifest = manifest
      @manifest_json = read_manifest(manifest)
    end

    def find_all_custom_elements
      json = @manifest_json
      custom_elements = {}

      json["modules"].flatten.each do |mod|
        parent_module = mod
        mod["declarations"].flatten.each do |dec|
          # Needs to be != true because == false fails nil checks.
          next if dec["customElement"] != true

          tag_name = dec["tagName"]

          custom_elements[tag_name] = dec if tag_name
          dec["parent_module"] = parent_module
        end
      end

      custom_elements
    end

    def list_tag_names
      find_all_custom_elements.keys
    end
  end
end
