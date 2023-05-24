# Define a shared example
RSpec.shared_examples "a calculatable object" do
    it "returns the sum of two numbers" do
      expect(subject.add(2, 3)).to eq(5)
    end
  
    it "returns the difference between two numbers" do
      expect(subject.subtract(5, 2)).to eq(3)
    end
end
  
  # Define a shared context
RSpec.shared_context "with a calculator" do
    let(:calculator) { Calculator.new }
    subject { calculator }
end
  
  # Example usage of shared example and shared context
RSpec.describe Calculator do
    include_context "with a calculator"
  
    it_behaves_like "a calculatable object"
    # include_examples_for "a calculatable object"
end
  