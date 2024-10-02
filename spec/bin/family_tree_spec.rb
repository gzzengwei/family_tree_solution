require "spec_helper"
require "open3"

RSpec.describe "bin/family_tree" do
  let(:script_path) { File.join(File.dirname(__FILE__), "..", "..", "bin", "family_tree") }
  let(:input_file_path) { File.join(File.dirname(__FILE__), "..", "data", "input.txt") }

  it "processes the input file and produces the expected output" do
    output, status = Open3.capture2("ruby #{script_path} #{input_file_path}")

    expect(status.success?).to be true

    expected_output = [
      "CHILD_ADDED",
      "Dominique Minerva",
      "Victoire Dominique Louis",
      "PERSON_NOT_FOUND",
      "PERSON_NOT_FOUND",
      "CHILD_ADDITION_FAILED",
      "NONE",
      "Darcy Alice"
    ].join("\n") + "\n"

    expect(output).to eq(expected_output)
  end
end
