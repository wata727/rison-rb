class Rison::Object::Parser
rule

target: QUOTE QUOTE  { result = {} }
      | members

object: LPAREN RPAREN          { result = {} }
      | LPAREN members RPAREN  { result = val[1] }

members: pair
       | pair COMMA members  { result = val[0].merge(val[2]) }

pair: key COLON value  { result = { val[0] => val[2] } }

array: EXCLAM LPAREN RPAREN           { result = [] }
     | EXCLAM LPAREN elements RPAREN  { result = val[2] }

elements: value                 { result = [val[0]] }
        | value COMMA elements  { result = val[2].unshift(val[0]) }

key: id | string

value: id | string | number | object | array | bool | null

bool: EXCLAM T  { result = true }
    | EXCLAM F  { result = false }

null: EXCLAM N  { result = nil }

id: idstart
  | idstart idchars  { result = val[0] + val[1] }

idchars: idchar
       | idchar idchars  { result = val[0] + val[1] }

idchar: IDCHAR | idstart | MINUS | DIGIT

idstart: IDSTART | E | T | F | N | DOT

string: QUOTE QUOTE           { result = '' }
      | QUOTE strchars QUOTE  { result = val[1] }

strchars: strchar
        | strchar strchars  { result = val[0] + val[1] }

strchar: STRCHAR
       | idchar
       | EXCLAM EXCLAM  { result = '!' }
       | EXCLAM QUOTE   { result = "'" }
       | COLON
       | LPAREN
       | RPAREN
       | COMMA

number: int           { result = val[0].to_i }
      | int frac      { result = "#{val[0]}#{val[1]}".to_f }
      | int exp       { result = "#{val[0]}#{val[1]}".to_f }
      | int frac exp  { result = "#{val[0]}#{val[1]}#{val[2]}".to_f }

int : DIGIT               { result = val[0].to_i }
    | DIGIT digits        { result = "#{val[0]}#{val[1]}".to_i }
    | MINUS DIGIT         { result = "-#{val[1]}".to_i }
    | MINUS DIGIT digits  { result = "-#{val[1]}#{val[2]}".to_i }

frac: DOT digits  { result = "#{val[0]}#{val[1]}" }

exp: e digits  { result = "#{val[0]}#{val[1]}" }

digits: DIGIT
      | DIGIT digits  { result = "#{val[0]}#{val[1]}" }

e: E        { result = 'e' }
 | E MINUS  { result = "e-" }

---- inner

attr_reader :source, :input

def initialize(source)
  @source = source
  @input = StringScanner.new(source)
end

def self.parse(source)
  self.new(source).do_parse
rescue Racc::ParseError => exn
  raise ParserError.new("#{exn.message} in #{source}")
end

def next_token
  case
  when input.eos?
    [false, false]
  when input.scan(/'/)
    [:QUOTE, input.matched]
  when input.scan(/\(/)
    [:LPAREN, input.matched]
  when input.scan(/\)/)
    [:RPAREN, input.matched]
  when input.scan(/:/)
    [:COLON, input.matched]
  when input.scan(/\./)
    [:DOT, input.matched]
  when input.scan(/\,/)
    [:COMMA, input.matched]
  when input.scan(/!/)
    [:EXCLAM, input.matched]
  when input.scan(/\-/)
    [:MINUS, input.matched]
  when input.scan(/e/)
    [:E, input.matched]
  when input.scan(/t/)
    [:T, input.matched]
  when input.scan(/f/)
    [:F, input.matched]
  when input.scan(/n/)
    [:N, input.matched]
  # Originally, 0 is not allowed at the beginning of the number, but rison.js accepts this.
  when input.scan(/[0-9]/)
    [:DIGIT, input.matched]
  # IDSTART and IDCHAR should originally accept only the ASCII symbols `-_./~`, but rison.js accepts other symbols.
  # @see https://rison.io/
  # @see https://github.com/Nanonid/rison/blob/e64af6c096fd30950ec32cfd48526ca6ee21649d/js/rison.js#L77-L84
  when input.scan(/[^\-0-9 '!:\(\),\*@\$]/)
    [:IDSTART, input.matched]
  when input.scan(/[^ '!:\(\),\*@\$]/)
    [:IDCHAR, input.matched]
  when input.scan(/[^\'\!]/)
    [:STRCHAR, input.matched]
  end
end
