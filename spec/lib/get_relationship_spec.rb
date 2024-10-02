# frozen_string_literal: true

require "spec_helper"

RSpec.describe FamilyTree::GetRelationship do
  let(:family_data) { FamilyTree::Parser.call(file_path: "spec/data/family_tree.json") }
  let(:family_tree) { FamilyTree::BuildTree.new(family_data).build }
  let(:get_relationship) { FamilyTree::GetRelationship.new(family_tree) }

  describe "#get" do
    it "returns nil for non-existent person" do
      result = get_relationship.get("NonExistent", "Siblings")
      expect(result).to be_nil
    end

    it "returns siblings correctly" do
      siblings = get_relationship.get("Bill", "Siblings")
      sibling_names = siblings.map(&:name)
      expect(sibling_names).to include("Ginerva", "Percy")
    end

    it "returns paternal-uncle correctly" do
      uncles = get_relationship.get("William", "Paternal-Uncle")
      uncle_names = uncles.map(&:name)
      expect(uncle_names).to eq(["Albus"])
    end

    it "returns maternal-aunt correctly" do
      aunts = get_relationship.get("Remus", "Maternal-Aunt")
      aunt_names = aunts.map(&:name)
      expect(aunt_names).to eq(["Dominique"])
    end

    it "returns sister-in-law from siblings correctly" do
      sisters_in_law = get_relationship.get("Lily", "Sister-In-Law")
      sister_in_law_names = sisters_in_law.map(&:name)
      expect(sister_in_law_names).to include("Darcy", "Alice")
    end

    it "returns sister-in-law from spouse correctly" do
      sisters_in_law = get_relationship.get("Audrey", "Sister-In-Law")
      sister_in_law_names = sisters_in_law.map(&:name)
      expect(sister_in_law_names).to include("Ginerva")
    end

    it "returns brother-in-law from sibilings correctly" do
      brothers_in_law = get_relationship.get("Ronald", "Brother-In-Law")
      brother_in_law_names = brothers_in_law.map(&:name)
      expect(brother_in_law_names).to include("Harry")
    end

    it "returns brother-in-law from spouse correctly" do
      brothers_in_law = get_relationship.get("Alice", "Brother-In-Law")
      brother_in_law_names = brothers_in_law.map(&:name)
      expect(brother_in_law_names).to include("James")
    end

    it "returns son correctly" do
      sons = get_relationship.get("Bill", "Son")
      son_names = sons.map(&:name)
      expect(son_names).to include("Louis")
    end

    it "returns daughter correctly" do
      daughters = get_relationship.get("Bill", "Daughter")
      daughter_names = daughters.map(&:name)
      expect(daughter_names).to include("Victoire", "Dominique")
    end

    it "returns empty array for non-existent relationship" do
      result = get_relationship.get("Remus", "Son")
      expect(result).to eq([])
    end

    it "returns nil for unknown relationship" do
      result = get_relationship.get("Bill", "Unknown")
      expect(result).to be_nil
    end
  end
end
