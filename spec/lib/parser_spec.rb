require "spec_helper"
require "family_tree/parser"

RSpec.describe FamilyTree::Parser do
  let(:valid_json_path) { "spec/fixtures/valid_family_tree.json" }
  let(:invalid_json_path) { "spec/fixtures/invalid_family_tree.json" }
  let(:non_existent_path) { "spec/fixtures/non_existent.json" }

  describe ".call" do
    context "with a valid JSON file" do
      it "successfully parses the JSON file" do
        result = FamilyTree::Parser.call(file_path: valid_json_path)
        expect(result).to be_a(Hash)
        expect(result["name"]).to eq("King Arthur")
      end
    end

    context "with an invalid JSON file" do
      it "raises a FamilyTree::Error" do
        expect {
          FamilyTree::Parser.call(file_path: invalid_json_path)
        }.to raise_error(FamilyTree::Error, /Invalid JSON format in file/)
      end
    end

    context "with a non-existent file" do
      it "raises a FamilyTree::Error" do
        expect {
          FamilyTree::Parser.call(file_path: non_existent_path)
        }.to raise_error(FamilyTree::Error, /File not found/)
      end
    end
  end
end
