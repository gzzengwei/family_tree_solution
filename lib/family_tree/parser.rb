require "json"

module FamilyTree
  class Parser
    def self.call(file_path:)
      new(file_path).parse
    end

    def initialize(file_path)
      @file_path = file_path
    end

    def parse
      JSON.parse(File.read(@file_path))
    rescue Errno::ENOENT
      raise FamilyTree::Error, "File not found: #{@file_path}"
    rescue JSON::ParserError
      raise FamilyTree::Error, "Invalid JSON format in file: #{@file_path}"
    end
  end
end
