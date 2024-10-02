module FamilyTree
  class App
    def initialize(tree)
      @tree = tree
      @get_relationship = GetRelationship.new(tree)
    end

    def add_child(mother_name, child_name, gender)
      mother = @get_relationship.find_person(mother_name)
      return "PERSON_NOT_FOUND" if mother.nil?
      return "CHILD_ADDITION_FAILED" if mother.gender == "Male"

      child = Person.new(child_name, gender)
      mother.add_child(child)
      "CHILD_ADDED"
    end

    def get_relationship(name, relationship)
      result = @get_relationship.get(name, relationship)
      return "PERSON_NOT_FOUND" if result.nil?
      return "NONE" if result.empty?

      result.map(&:name).join(" ")
    end
  end
end
