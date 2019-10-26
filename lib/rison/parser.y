class Rison::Parser
rule

target: value

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

value: id | string | number | object | array | BOOL | NULL

id: idstart
  | idstart idchars  { result = val[0] + val[1] }

idchars: idchar
       | idchar idchars  { result = val[0] + val[1] }

idchar: IDCHAR | idstart | MINUS | DIGIT | DIGIT19

idstart: IDSTART | NAPIER | DOT | NONASCIICHAR

string: QUOTE QUOTE           { result = '' }
      | QUOTE strchars QUOTE  { result = val[1] }

strchars: strchar
        | strchar strchars  { result = val[0] + val[1] }

strchar: STRCHAR
       | idchar
       | EXCLAM EXCLAM  { result = '!' }
       | EXCLAM QUOTE   { result = "'" }

number: int           { result = val[0].to_i }
      | int frac      { result = "#{val[0]}#{val[1]}".to_f }
      | int exp       { result = "#{val[0]}#{val[1]}".to_f }
      | int frac exp  { result = "#{val[0]}#{val[1]}#{val[2]}".to_f }

int : DIGIT                 { result = val[0].to_i }
    | DIGIT19               { result = val[0].to_i }
    | DIGIT19 digits        { result = "#{val[0]}#{val[1]}".to_i }
    | MINUS DIGIT           { result = "-#{val[1]}".to_i }
    | MINUS DIGIT19         { result = "-#{val[1]}".to_i }
    | MINUS DIGIT19 digits  { result = "-#{val[1]}#{val[2]}".to_i }

frac: DOT digits  { result = "#{val[0]}#{val[1]}" }

exp: e digits  { result = "#{val[0]}#{val[1]}" }

digits: DIGIT
      | DIGIT digits    { result = "#{val[0]}#{val[1]}" }
      | DIGIT19
      | DIGIT19 digits  { result = "#{val[0]}#{val[1]}" }

e: NAPIER        { result = 'e' }
 | NAPIER MINUS  { result = "e-" }

---- inner

class ParseError < Racc::ParseError; end

attr_reader :source, :input

def initialize(source)
  @source = source
  @input = StringScanner.new(source)
end

def self.parse(source)
  self.new(source).do_parse
rescue Racc::ParseError => exn
  raise ParseError.new(exn.message)
end

def next_token
  case
  when input.eos?
    [false, false]
  when input.scan(/!t\b/)
    [:BOOL, true]
  when input.scan(/!f\b/)
    [:BOOL, false]
  when input.scan(/!n\b/)
    [:NULL, nil]
  when input.scan(/'/)
    [:QUOTE, nil]
  when input.scan(/\(/)
    [:LPAREN, nil]
  when input.scan(/\)/)
    [:RPAREN, nil]
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
    [:NAPIER, input.matched]
  when input.scan(/[1-9]/)
    [:DIGIT19, input.matched]
  when input.scan(/[0-9]/)
    [:DIGIT, input.matched]
  when input.scan(/[a-zA-Z_\.\/~]/)
    [:IDSTART, input.matched]
  when input.scan(/[a-zA-Z_\.\/~\-0-9]/)
    [:IDCHAR, input.matched]
  when input.scan(/[^[:ascii:]]/)
    [:NONASCIICHAR, input.matched]
  when input.scan(/[^\'\!]/)
    [:STRCHAR, input.matched]
  end
end
