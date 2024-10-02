require "spec_helper"

RSpec.describe FamilyTree::App do
  let(:family_data) { FamilyTree::Parser.call(file_path: "spec/fixtures/valid_family_tree.json") }
  let(:family_tree) { FamilyTree::BuildTree.new(family_data).build }
  let(:app) { FamilyTree::App.new(family_tree) }

  describe "#add_child" do
    it "adds a child successfully" do
      result = app.add_child("Queen Margret", "New Child", "Female")
      expect(result).to eq("CHILD_ADDED")
    end

    it "fails to add a child to a non-existent person" do
      result = app.add_child("Non Existent", "New Child", "Male")
      expect(result).to eq("PERSON_NOT_FOUND")
    end

    it "fails to add a child to a male" do
      result = app.add_child("King Arthur", "New Child", "Female")
      expect(result).to eq("CHILD_ADDITION_FAILED")
    end
  end

  describe "#get_relationship" do
    it "returns siblings correctly" do
      result = app.get_relationship("Bill", "Siblings")
      expect(result).to include("Ginerva", "Percy")
    end

    it "returns NONE for non-existent relationship" do
      result = app.get_relationship("Remus", "Son")
      expect(result).to eq("NONE")
    end

    it "returns PERSON_NOT_FOUND for non-existent person" do
      result = app.get_relationship("Non Existent", "Siblings")
      expect(result).to eq("PERSON_NOT_FOUND")
    end
  end
end
