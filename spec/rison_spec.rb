RSpec.describe Rison do
  it "has a version number" do
    expect(Rison::VERSION).not_to be nil
  end

  describe '.parse' do
    let(:source) { "(a:!(foo,(e:bar),baz),b:(c:1,d:!f))" }

    it "parses into a hash with string keys" do
      expect(Rison.parse(source)).to eq({
        'a' => ['foo', { 'e' => 'bar' }, 'baz'],
        'b' => { 'c' => 1, 'd' => false }, 
      })
    end

    it "parses into a hash with symbol keys" do
      expect(Rison.parse(source, symbolize_names: true)).to eq({
        a: ['foo', { e: 'bar' }, 'baz'],
        b: { c: 1, d: false }, 
      })
    end
  end
end
