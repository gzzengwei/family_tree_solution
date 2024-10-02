# frozen_string_literal: true

require_relative "family_tree/build_tree"
require_relative "family_tree/get_relationship"
require_relative "family_tree/parser"
require_relative "family_tree/person"
require_relative "family_tree/version"

module FamilyTree
  class Error < StandardError; end
  # Your code goes here...
end
