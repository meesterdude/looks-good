require 'looks_good'
require 'rspec'
RSpec::Matchers.define :look_like do |expected, within: LooksGood::Configuration.default_within|
  result = nil
  match do |actual|
    if expected.is_a?(Symbol)
      called_by_file = self.caller.find{|str| str.include?("_spec.rb")}
      path_to = called_by_file.split("_spec.rb").first.split("spec/").last
      expected = File.join(path_to, "#{expected}.png")
    end
    result = LooksGood.check(expected, actual, within: within)
    result[:result]
  end

  failure_message do |actual|
    actual_amount = result[:percent_difference] * 100
    expected_amount = result[:comparison].within * 100
    error_message = "expected '#{self.actual.path}' to match previous snapshot #{expected} by #{expected_amount.round(3)}%, but was off by #{actual_amount.round(3)}%\n"
    error_message += result[:message]
  end
end

