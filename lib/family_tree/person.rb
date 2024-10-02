module FamilyTree
  class Person
    attr_reader :name, :gender
    attr_accessor :mother, :father, :partner, :children

    def initialize(name, gender)
      @name = name
      @gender = gender
      @children = []
    end

    def add_child(child)
      @children << child
      if gender == "Female"
        child.mother = self
        child.father = partner if partner
      else
        child.father = self
        child.mother = partner if partner
      end
    end

    def add_partner(partner)
      self.partner = partner
      partner.partner = self
    end
  end
end
