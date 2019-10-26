RSpec.describe Rison::Parser do
  [
    ['!t', true],
    ['!f', false],
    ['!n', nil],
    ['0', 0],
    ['1', 1],
    ['42', 42],
    ['-3', -3],
    ['-33', -33],
    ['1e30', 1e30],
    ['1e-30', 1e-30],
    ['1.5', 1.5],
    ['99.99', 99.99],
    ['1.5e2', 150],
    ['a', 'a'],
    ['a-z', 'a-z'],
    ['domain.com', 'domain.com'],
    ['文字列', '文字列'],
    ['数学A', '数学A'],
    ['BN記法', 'BN記法'],
    [%(''), ''],
    [%('0a'), '0a'],
    [%('10'), '10'],
    [%('-h'), '-h'],
    [%('abc def'), 'abc def'],
    [%('user@domain.com'), 'user@domain.com'],
    [%('US $10'), 'US $10'],
    [%('文字列'), '文字列'],
    [%('数学A'), '数学A'],
    [%('BN記法'), 'BN記法'],
    [%('wow!!'), 'wow!'],
    [%('can!'t'), "can't"],
    ['()', {}],
    ['(a:0)', { 'a' => 0 }],
    ['(a:0,b:1)', { 'a' => 0, 'b' => 1 }],
    ["(a:0,b:foo,c:'23skidoo')", { 'a' => 0, 'b' => 'foo', 'c' => '23skidoo' }],
    ['(id:!n,type:/common/document)', { 'id' => nil, 'type' => '/common/document' }],
    ['!()', []],
    ['!(!t)', [true]],
    ['!(!f)', [false]],
    ['!(!t,!f)', [true, false]],
    ['!(!t,!f,!n,123)', [true, false, nil, 123]],
  ].each do |source, expected|
    it "#{source} => #{expected.inspect}" do
      expect(described_class.parse(source)).to eq expected
    end
  end

  [
    '-h',
    '1.5e+2',
    '1.5E2',
    '1.5E+2',
    '1.5E-2',
    'abc def',
    'US $10',
    'user@domain.com',
    '!',
    %('!'),
  ].each do |source|
    it "#{source} => ParseError" do
      expect { described_class.parse(source) }.to raise_error(Rison::Parser::ParseError)
    end
  end
end
