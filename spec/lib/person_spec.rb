require "spec_helper"

RSpec.describe FamilyTree::Person do
  let(:father) { FamilyTree::Person.new("John", "Male") }
  let(:mother) { FamilyTree::Person.new("Jane", "Female") }
  let(:child) { FamilyTree::Person.new("Junior", "Male") }

  describe "#initialize" do
    it "creates a person with a name and gender" do
      expect(father.name).to eq("John")
      expect(father.gender).to eq("Male")
    end

    it "initializes children as an empty array" do
      expect(father.children).to be_empty
    end
  end

  describe "#add_child" do
    context "when parent is male" do
      before do
        father.add_child(child)
      end

      it "adds a child to the person" do
        expect(father.children).to include(child)
      end

      it "sets the father" do
        expect(child.father).to eq(father)
      end

      it "does not set the mother" do
        expect(child.mother).to be_nil
      end

      context "when partner is present" do
        before do
          father.add_partner(mother)
          father.add_child(child)
        end

        it "sets both father and mother" do
          expect(child.father).to eq(father)
          expect(child.mother).to eq(mother)
        end
      end
    end

    context "when parent is female" do
      before do
        mother.add_child(child)
      end

      it "adds a child to the person" do
        expect(mother.children).to include(child)
      end

      it "sets the mother" do
        expect(child.mother).to eq(mother)
      end

      it "does not set the father" do
        expect(child.father).to be_nil
      end

      context "when partner is present" do
        before do
          mother.add_partner(father)
          mother.add_child(child)
        end

        it "sets both father and mother" do
          expect(child.mother).to eq(mother)
          expect(child.father).to eq(father)
        end
      end
    end
  end

  describe "#add_partner" do
    before { father.add_partner(mother) }

    it "sets the partner for both people" do
      expect(father.partner).to eq(mother)
      expect(mother.partner).to eq(father)
    end
  end
end
