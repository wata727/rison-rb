RSpec.describe Rison::Dumper do
  [
    [true, '!t'],
    [false, '!f'],
    [nil, '!n'],
    [0, '0'],
    [1, '1'],
    [12, '12'],
    [42, '42'],
    [-3, '-3'],
    [-33, '-33'],
    [1e30, '1.0e30'],
    [1e-30, '1.0e-30'],
    [1.5, '1.5'],
    [99.99, '99.99'],
    [150, '150'],
    ['e-', 'e-'],
    ['a', 'a'],
    ['a-z', 'a-z'],
    ['domain.com', 'domain.com'],
    ['文字列', '文字列'],
    ['数学A', '数学A'],
    ['BN記法', 'BN記法'],
    ['前>次', '前>次'],
    ['', %('')],
    ['0a', %('0a')],
    ['10', %('10')],
    ['012', %('012')],
    ['-1', %('-1')],
    ['-h', %('-h')],
    ['abc def', %('abc def')],
    ['user@domain.com', %('user@domain.com')],
    ['US $10', %('US $10')],
    ['wow!', %('wow!!')],
    ["can't", %('can!'t')],
    ["'", %('!'')],
    ['!t', %('!!t')],
    [{}, '()'],
    [{ 'a' => 0 }, '(a:0)'],
    [{ 'a' => 0, 'b' => 1 }, '(a:0,b:1)'],
    [{ a: 0, b: 1 }, '(a:0,b:1)'],
    [{ 'a' => 0, 'b' => 'foo', 'c' => '23skidoo' }, "(a:0,b:foo,c:'23skidoo')"],
    [{ 'id' => nil, 'type' => '/common/document' }, '(id:!n,type:/common/document)'],
    [{ 'a' => [1, 2, 3], 'b' => true, 'c' => '' }, "(a:!(1,2,3),b:!t,c:'')"],
    [[], '!()'],
    [[true], '!(!t)'],
    [[false], '!(!f)'],
    [[true, false], '!(!t,!f)'],
    [[true, false, nil, 123], '!(!t,!f,!n,123)'],
  ].each do |object, expected|
    it "#{object.inspect} => #{expected}" do
      expect(described_class.dump(object)).to eq expected
    end
  end
end
