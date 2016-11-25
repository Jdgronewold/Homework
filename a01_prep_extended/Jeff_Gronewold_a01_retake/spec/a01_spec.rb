require 'rspec'
require 'spec_helper'
require 'a01'

describe '#binary_search' do
  # add a method to the Array class that performs a binary search for
  # an element and returns its index
  let(:arr) { [1, 2, 3, 4, 6] }

  it "returns nil if the array is empty" do
    expect([].binary_search(1)).to be_nil
  end

  it "returns the index of a target" do
    expect(arr.binary_search(3)).to eq(2)
  end

  it "returns the index of a target that's less than the midpoint" do
    expect(arr.binary_search(2)).to eq(1)
  end

  it "returns the index of a target that's greater than the midpoint" do
    expect(arr.binary_search(6)).to eq(4)
  end

  it "returns nil if the target isn't found" do
    expect(arr.binary_search(5)).to be_nil
  end

  it "does not call any blacklisted methods" do
    disallowed_methods = [
      :index, :find_index, :include?, :member?
    ]

    disallowed_methods.each do |method|
      expect(arr).not_to receive(method)
    end

    arr.binary_search(5)
    arr.binary_search(1)
  end

  it "doesn't index into the array more than necessary" do
    expect(arr).to receive(:[]).at_most(3).times.and_call_original

    arr.binary_search(3)
  end
end

describe "#dups" do
  # Write a new Array method (using monkey-patching) that will return
  # the location of all identical elements. The keys are the
  # duplicated elements, and the values are arrays of their positions,
  # sorted lowest to highest.

  it "solves a simple example" do
    expect([1, 3, 0, 1].dups).to eq({ 1 => [0, 3] })
  end

  it "finds two dups" do
    expect([1, 3, 0, 3, 1].dups).to eq({ 1 => [0, 4], 3 => [1, 3] })
  end

  it "finds multi-dups" do
    expect([1, 3, 4, 3, 0, 3].dups).to eq({ 3 => [1, 3, 5] })
  end

  it "returns {} when no dups found" do
    expect([1, 3, 4, 5].dups).to eq({})
  end
end

describe "#fibs_rec" do
  # write a recursive implementation of a method that returns the
  # first `n` fibonacci numbers.

  it "returns first fibonacci number" do
    expect(fibs_rec(1)).to eq([0])
  end

  it "returns first two fib numbers" do
    expect(fibs_rec(2)).to eq([0, 1])
  end

  it "returns many fibonacci numbers" do
    expect(fibs_rec(6)).to eq([0, 1, 1, 2, 3, 5])
  end

  it "calls itself recursively" do
    expect(self).to receive(:fibs_rec).at_least(:twice).and_call_original
    fibs_rec(6)
  end
end

describe '#uniq_subs' do
  # write a method that finds all the unique substrings for a word

  it "returns an array" do
    expect("substring".uniq_subs).to be_a(Array)
  end

  it "does not return any duplicate substrings" do
    expect("stringstring".uniq_subs.uniq).to eq("stringstring".uniq_subs)
  end

  it "returns all unique substrings" do
    expect("str".uniq_subs).to match(["s", "st", "str", "t", "tr", "r"])
  end

  it "returns all unique substrings II" do
    expect("abab".uniq_subs).to match([
      "a",
      "ab",
      "aba",
      "abab",
      "b",
      "ba",
      "bab"
      ])
  end
end

describe 'sum_n_primes' do
  it "returns 0 for 0" do
    expect(sum_n_primes(0)).to be_zero
  end

  it "returns 2 for 1" do
    expect(sum_n_primes(1)).to eq(2)
  end

  it "can sum the first 4 primes" do
    expect(sum_n_primes(4)).to eq(17)
  end

  it "can handle larger numbers" do
    expect(sum_n_primes(20)).to eq(639)
  end
end

describe 'Array#my_each' do
  it 'calls the block passed to it' do
    expect do |block|
      ["test array"].my_each(&block)
    end.to yield_control.once
  end

  it 'yields each element to the block' do
    expect do |block|
      ["el1", "el2"].my_each(&block)
    end.to yield_successive_args("el1", "el2")
  end

  it 'does NOT call the Array#each or Array#map! method' do
    original_array = ["original array"]
    expect(original_array).not_to receive(:each)
    expect(original_array).not_to receive(:map!)
    original_array.my_each {}
  end

  it 'is chainable and returns the original array' do
    original_array = ["original array"]
    expect(original_array.my_each {}).to be(original_array)
  end
end

describe 'Array#my_all?' do
  it 'calls the block passed to it' do
    expect do |block|
      [true].my_all?(&block)
    end.to yield_control
  end

  it 'returns false if any call to the block evaluates to a falsey value' do
    expect([true, false, true].my_all? { |el| el }).to eq(false)
    expect([true, nil, true].my_all? { |el| el }).to eq(false)
  end

  it 'returns true if every call to the block evaluates to true' do
    expect([2, 4, 6].my_all? { |el| el.even? }).to eq(true)
  end

  it 'returns true if every call to the block evaluates to truthy values' do
    expect([:a, :b, :c].my_all? { |el| el }).to eq(true)
  end

  it 'does NOT call the built-in Array#all?, #none?, #any?' do
    test_array = ["el1", "el2", "el3"]

    [:all?, :none?, :any?].each do |method|
      expect(test_array).not_to receive(method)
    end

    test_array.my_all? {}
  end
end

