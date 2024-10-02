# frozen_string_literal: true

require "set"

module FamilyTree
  class GetRelationship
    attr_reader :tree

    def initialize(tree)
      @tree = tree
    end

    def get(name, relationship)
      person = find_person(name)
      return nil unless person

      case relationship
      when "Paternal-Uncle"
        paternal_uncles(person)
      when "Maternal-Uncle"
        maternal_uncles(person)
      when "Paternal-Aunt"
        paternal_aunts(person)
      when "Maternal-Aunt"
        maternal_aunts(person)
      when "Sister-In-Law"
        sisters_in_law(person)
      when "Brother-In-Law"
        brothers_in_law(person)
      when "Son"
        sons(person)
      when "Daughter"
        daughters(person)
      when "Siblings"
        siblings(person)
      end
    end

    def find_person(name)
      find_person_recursive(tree, name, Set.new)
    end

    private

    def find_person_recursive(node, name, visited)
      return nil if node.nil? || visited.include?(node)
      return node if node.name == name

      visited.add(node)

      ([node.partner] + node.children).compact.each do |related_person|
        result = find_person_recursive(related_person, name, visited)
        return result if result
      end

      nil
    end

    def paternal_uncles(person)
      return [] unless person.father

      siblings(person.father)
        .select { |sibling| sibling.gender == "Male" }
        .reject { |sibling| sibling == person.father }
    end

    def maternal_uncles(person)
      return [] unless person.mother

      siblings(person.mother)
        .select { |sibling| sibling.gender == "Male" }
    end

    def paternal_aunts(person)
      return [] unless person.father

      siblings(person.father).select { |sibling| sibling.gender == "Female" }
    end

    def maternal_aunts(person)
      return [] unless person.mother

      siblings(person.mother)
        .select { |sibling| sibling.gender == "Female" }
        .reject { |sibling| sibling == person.mother }
    end

    def sisters_in_law(person)
      spouse_sisters(person) + sibling_wives(person)
    end

    def brothers_in_law(person)
      spouse_brothers(person) + sibling_husbands(person)
    end

    def sons(person)
      children(person).select { |child| child.gender == "Male" }
    end

    def daughters(person)
      children(person).select { |child| child.gender == "Female" }
    end

    def siblings(person)
      return [] unless person.mother

      person.mother.children.reject { |child| person == child }
    end

    private

    def children(person)
      if person.gender == "Male"
        return [] unless person.partner

        person.partner.children
      else
        person.children
      end
    end

    def spouse_sisters(person)
      return [] unless person.partner

      siblings(person.partner)
        .select { |sibling| sibling.gender == "Female" }
    end

    def sibling_wives(person)
      siblings(person).map(&:partner).compact.select { |partner| partner.gender == "Female" }
    end

    def spouse_brothers(person)
      return [] unless person.partner

      siblings(person.partner)
        .select { |sibling| sibling.gender == "Male" }
    end

    def sibling_husbands(person)
      siblings(person).map(&:partner).compact
        .select { |partner| partner.gender == "Male" }
    end
  end
end
