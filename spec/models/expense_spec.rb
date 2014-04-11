require 'spec_helper'

describe Expense do
  it "should not save entry with blank validated fields" do
    Expense.new(name: nil, amount: nil).should_not be_valid
  end
end
