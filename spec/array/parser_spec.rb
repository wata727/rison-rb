RSpec.describe Rison::Array::Parser do
  [
    ['foo,bar,(a:1,b:!(!t))', ['foo', 'bar', { 'a' => 1, 'b' => [true] }]],
    [%(''), []],
    [%('',''), ['', '']],
    ['-1', [-1]],
  ].each do |source, expected|
    it "#{source} => #{expected.inspect}" do
      expect(described_class.parse(source)).to eq expected
    end
  end
end
