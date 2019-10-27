RSpec.describe Rison::Object::Dumper do
  [
    [{ 'a' => 1, 'b' => { 'c' => true, 'd' => ['foo', 'bar'] } }, 'a:1,b:(c:!t,d:!(foo,bar))'],
    [{}, %('')],
    [{ 'a' => '' }, %(a:'')],
  ].each do |object, expected|
    it "#{object} => #{expected.inspect}" do
      expect(described_class.dump_object(object)).to eq expected
    end
  end

  [
    true,
    1,
    'string',
  ].each do |object|
    it "#{object} => DumperError" do
      expect { described_class.dump_object(object) }.to raise_error(Rison::DumperError)
    end
  end
end
