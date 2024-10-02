require "spec_helper"

RSpec.describe FamilyTree::BuildTree do
  let(:family_data) { FamilyTree::Parser.call(file_path: "spec/fixtures/valid_family_tree.json") }
  let(:build_tree) { FamilyTree::BuildTree.new(family_data) }
  let(:family_tree) { build_tree.build }

  describe ".call" do
    it "builds a family tree from the given data" do
      expect(family_tree).to be_a(FamilyTree::Person)
      expect(family_tree.name).to eq("King Arthur")
    end

    it "correctly sets up partnerships" do
      expect(family_tree.partner.name).to eq("Queen Margret")
      expect(family_tree.partner.partner).to eq(family_tree)
    end

    it "correctly sets up parent-child relationships" do
      expect(family_tree.partner.children.map(&:name)).to include("Bill", "Ginerva", "Percy")
      expect(family_tree.partner.children.first.mother).to eq(family_tree.partner)
      expect(family_tree.partner.children.first.father).to eq(family_tree)
    end

    it "handles nested family structures" do
      bill = family_tree.partner.children.find { |child| child.name == "Bill" }
      expect(bill.partner.name).to eq("Flora")
      expect(bill.partner.children.map(&:name)).to include("Victoire", "Dominique", "Louis")

      victoire = bill.partner.children.find { |child| child.name == "Victoire" }
      expect(victoire.partner.name).to eq("Ted")
      expect(victoire.children.map(&:name)).to include("Remus", "Nymphadora")
    end

    it "only adds children through the mother" do
      ginerva = family_tree.partner.children.find { |child| child.name == "Ginerva" }
      expect(ginerva.children.map(&:name)).to include("James", "Lily")

      james = ginerva.children.find { |child| child.name == "James" }
      expect(james.children).to be_empty
      expect(james.partner.children.map(&:name)).to include("Albus")
    end

    it "handles male partners without children correctly" do
      percy = family_tree.partner.children.find { |child| child.name == "Percy" }
      expect(percy.children).to be_empty
      expect(percy.partner.children.map(&:name)).to include("Molly", "Lucy")
    end
  end
end
