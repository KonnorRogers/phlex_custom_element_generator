module PhlexCustomElementGenerator
  class CLI < Thor
    include Thor::Actions

    def self.exit_on_failure?
      true
    end

    def self.source_root
      File.dirname(__FILE__)
    end

    desc "Generates new Phlex components from a given `custom-elements.json`"
    def generate
    end
  end
end
