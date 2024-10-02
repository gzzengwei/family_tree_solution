module FamilyTree
  class BuildTree
    attr_reader :root

    def self.call(data)
      new(data).build
    end

    def initialize(data)
      @data = data
      @root = nil
    end

    def build
      @root = build_person(@data)
    end

    private

    def build_person(person_data)
      person = Person.new(person_data['name'], person_data['gender'])

      if person_data['partner']
        partner = build_person(person_data['partner'])
        person.add_partner(partner)
      end

      if person_data['children']
        person_data['children'].each do |child_data|
          child = build_person(child_data)
          if person.gender == 'Female'
            person.add_child(child)
          elsif person.partner
            person.partner.add_child(child)
          end
        end
      end

      person
    end
  end
end
