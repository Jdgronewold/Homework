require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  subject(:cake) { Dessert.new("cake", 50, :chef) }
  let(:chef) { double("chef") }

  describe "#initialize" do
    it "sets a type" do
      expect(cake.type).to eq("cake")
    end

    it "sets a quantity" do
      expect(cake.quantity).to eq(50)
    end

    it "starts ingredients as an empty array" do
      expect(cake.ingredients).to be_empty
    end

    ###### look here to see where to add the new subject
    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("cake", "lots", "bill")}.to raise_error(ArgumentError)
    end


  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      expect(cake.add_ingredient("flour")).to eq(["flour"])
    end
  end

  describe "#mix!" do

    it "shuffles the ingredient array" do
      cake.add_ingredient("flour")
      cake.add_ingredient("sugar")
      cake.add_ingredient("baking soda")
      cake.add_ingredient("egg")
      expect(cake.mix!).to_not eq(["flour", "sugar", "baking soda", "egg"])
    end
  end

  describe "#eat" do

    it "subtracts an amount from the quantity" do
      cake.eat(20)
      expect(cake.quantity).to eq(30)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { cake.eat(60) }.to raise_error('not enough left!')

    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(:chef).to receive(:titleize).and_return("Chef bill the Great Baker")
      cake.serve


    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in"
  end
end
