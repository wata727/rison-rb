RSpec.describe Rison::ObjectParser do
  [
    ['a:1,b:(c:!t,d:!(foo,bar))', { 'a' => 1, 'b' => { 'c' => true, 'd' => ['foo', 'bar'] } }],
    [%(''), {}],
    [%(a:''), { 'a' => '' }],
  ].each do |source, expected|
    it "#{source} => #{expected.inspect}" do
      expect(described_class.parse(source)).to eq expected
    end
  end

  [
    '(a:1,b:(c:!t,d:!(foo,bar)))',
    '!t',
    '1',
    '%(string)',
  ].each do |source|
    it "#{source} => ParserError" do
      expect { described_class.parse(source) }.to raise_error(Rison::ParserError)
    end
  end
end
