RSpec.describe Rison::Array::Dumper do
  [
    [['foo', 'bar', { 'a' => 1, 'b' => [true] }], 'foo,bar,(a:1,b:!(!t))'],
    [[], %('')],
    [['', ''], %('','')],
    [[-1], '-1'],
  ].each do |object, expected|
    it "#{object} => #{expected.inspect}" do
      expect(described_class.dump_array(object)).to eq expected
    end
  end

  [
    true,
    1,
    'string',
  ].each do |object|
    it "#{object} => DumperError" do
      expect { described_class.dump_array(object) }.to raise_error(Rison::DumperError)
    end
  end
end
