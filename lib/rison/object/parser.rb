#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.15
# from Racc grammer file "".
#

require 'racc/parser.rb'
module Rison
  module Object
    class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 72)

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
  when input.scan(/[^\-0-9 '!:\(\),\*@¥\$]/)
    [:IDSTART, input.matched]
  when input.scan(/[^ '!:\(\),\*@¥\$]/)
    [:IDCHAR, input.matched]
  when input.scan(/[^\'\!]/)
    [:STRCHAR, input.matched]
  end
end
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
    16,    62,    60,    65,    66,    25,    11,    12,    13,    17,
    19,    20,     9,    10,    14,    23,    51,    77,    62,    64,
    64,    25,    11,    12,    13,    17,    19,    20,     9,    10,
    14,    23,    36,    37,    73,    26,    27,    39,    11,    12,
    13,    36,    49,    48,     9,    10,    14,    11,    12,    13,
    30,    36,    37,     9,    10,    14,    39,    11,    12,    13,
    31,    49,    48,     9,    10,    14,    36,   -38,    52,    64,
    54,    64,    11,    12,    13,    55,    56,    57,     9,    10,
    14,    36,    37,    67,    15,    76,    39,    11,    12,    13,
     2,    49,    48,     9,    10,    14,    11,    12,    13,    64,
   nil,   nil,     9,    10,    14,    25,    11,    12,    13,    17,
    19,    20,     9,    10,    14,    23,    11,    12,    13,    17,
    19,    20,     9,    10,    14,    11,    12,    13,    17,    19,
    20,     9,    10,    14,    34,   nil,   nil,   nil,   nil,    33 ]

racc_action_check = [
     2,    47,    47,    49,    53,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,    36,    69,    58,    60,
    61,    36,    36,    36,    36,    36,    36,    36,    36,    36,
    36,    36,    77,    77,    62,     4,     5,    77,    77,    77,
    77,    26,    77,    77,    77,    77,    77,    26,    26,    26,
    15,    27,    27,    26,    26,    26,    27,    27,    27,    27,
    21,    27,    27,    27,    27,    27,    37,    16,    37,    64,
    39,    65,    37,    37,    37,    39,    39,    39,    37,    37,
    37,    54,    54,    54,     1,    68,    54,    54,    54,    54,
     0,    54,    54,    54,    54,    54,     0,     0,     0,    48,
   nil,   nil,     0,     0,     0,    22,    22,    22,    22,    22,
    22,    22,    22,    22,    22,    22,     8,     8,     8,     8,
     8,     8,     8,     8,     8,    29,    29,    29,    29,    29,
    29,    29,    29,    29,    25,   nil,   nil,   nil,   nil,    25 ]

racc_action_pointer = [
    88,    84,    -2,   nil,    30,    30,   nil,   nil,   108,   nil,
   nil,   nil,   nil,   nil,   nil,    50,    61,   nil,   nil,   nil,
   nil,    58,    98,   nil,   nil,   132,    39,    49,   nil,   117,
   nil,   nil,   nil,   nil,   nil,   nil,    14,    64,   nil,    67,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   -14,    86,   -10,
   nil,   nil,   nil,     0,    79,   nil,   nil,   nil,     3,   nil,
     6,     7,    22,   nil,    56,    58,   nil,   nil,    81,    12,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,    30,   nil ]

racc_action_default = [
   -60,   -60,   -60,    -2,    -5,   -60,   -12,   -13,   -24,   -32,
   -33,   -34,   -35,   -36,   -37,   -60,    -1,   -28,   -29,   -30,
   -31,   -60,   -40,   -42,   -43,   -60,   -60,   -60,   -25,   -26,
    79,   -39,   -41,   -44,   -45,    -6,   -60,   -60,    -7,   -60,
   -14,   -15,   -16,   -17,   -18,   -19,   -20,   -46,   -50,   -60,
   -27,   -38,    -3,   -60,   -60,   -21,   -22,   -23,   -47,   -48,
   -60,   -60,   -58,   -51,   -56,   -52,    -4,    -8,   -60,   -10,
   -49,   -54,   -55,   -59,   -57,   -53,    -9,   -60,   -11 ]

racc_goto_table = [
    40,    41,    68,     3,    18,    28,    63,    38,    32,    29,
    18,    58,     1,   nil,   nil,   nil,   nil,   nil,    71,    72,
   nil,    59,    74,    75,    18,    78,    50,    40,    41,    35,
    29,    18,    70,   nil,   nil,   nil,   nil,   nil,    18,   nil,
    53,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    40,    41 ]

racc_goto_check = [
     9,    10,     8,     2,    14,    15,    22,     6,    17,    16,
    14,    20,     1,   nil,   nil,   nil,   nil,   nil,    22,    22,
   nil,    21,    22,    22,    14,     8,    15,     9,    10,     2,
    16,    14,    21,   nil,   nil,   nil,   nil,   nil,    14,   nil,
     2,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
     9,    10 ]

racc_goto_pointer = [
   nil,    12,     3,   nil,   nil,   nil,   -20,   nil,   -52,   -27,
   -26,   nil,   nil,   nil,     2,    -3,     1,   -14,   nil,   nil,
   -36,   -26,   -42,   nil ]

racc_goto_default = [
   nil,   nil,   nil,    43,     4,     5,    69,    44,   nil,     6,
     7,    42,    45,    46,     8,   nil,    24,    21,    22,    47,
   nil,   nil,   nil,    61 ]

racc_reduce_table = [
  0, 0, :racc_error,
  2, 19, :_reduce_1,
  1, 19, :_reduce_none,
  2, 21, :_reduce_3,
  3, 21, :_reduce_4,
  1, 20, :_reduce_none,
  3, 20, :_reduce_6,
  3, 22, :_reduce_7,
  3, 25, :_reduce_8,
  4, 25, :_reduce_9,
  1, 26, :_reduce_10,
  3, 26, :_reduce_11,
  1, 23, :_reduce_none,
  1, 23, :_reduce_none,
  1, 24, :_reduce_none,
  1, 24, :_reduce_none,
  1, 24, :_reduce_none,
  1, 24, :_reduce_none,
  1, 24, :_reduce_none,
  1, 24, :_reduce_none,
  1, 24, :_reduce_none,
  2, 30, :_reduce_21,
  2, 30, :_reduce_22,
  2, 31, :_reduce_23,
  1, 27, :_reduce_none,
  2, 27, :_reduce_25,
  1, 33, :_reduce_none,
  2, 33, :_reduce_27,
  1, 34, :_reduce_none,
  1, 34, :_reduce_none,
  1, 34, :_reduce_none,
  1, 34, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  1, 32, :_reduce_none,
  2, 28, :_reduce_38,
  3, 28, :_reduce_39,
  1, 35, :_reduce_none,
  2, 35, :_reduce_41,
  1, 36, :_reduce_none,
  1, 36, :_reduce_none,
  2, 36, :_reduce_44,
  2, 36, :_reduce_45,
  1, 29, :_reduce_46,
  2, 29, :_reduce_47,
  2, 29, :_reduce_48,
  3, 29, :_reduce_49,
  1, 37, :_reduce_50,
  2, 37, :_reduce_51,
  2, 37, :_reduce_52,
  3, 37, :_reduce_53,
  2, 38, :_reduce_54,
  2, 39, :_reduce_55,
  1, 40, :_reduce_none,
  2, 40, :_reduce_57,
  1, 41, :_reduce_58,
  2, 41, :_reduce_59 ]

racc_reduce_n = 60

racc_shift_n = 79

racc_token_table = {
  false => 0,
  :error => 1,
  :QUOTE => 2,
  :LPAREN => 3,
  :RPAREN => 4,
  :COMMA => 5,
  :COLON => 6,
  :EXCLAM => 7,
  :T => 8,
  :F => 9,
  :N => 10,
  :IDCHAR => 11,
  :MINUS => 12,
  :DIGIT => 13,
  :IDSTART => 14,
  :E => 15,
  :DOT => 16,
  :STRCHAR => 17 }

racc_nt_base = 18

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "QUOTE",
  "LPAREN",
  "RPAREN",
  "COMMA",
  "COLON",
  "EXCLAM",
  "T",
  "F",
  "N",
  "IDCHAR",
  "MINUS",
  "DIGIT",
  "IDSTART",
  "E",
  "DOT",
  "STRCHAR",
  "$start",
  "target",
  "members",
  "object",
  "pair",
  "key",
  "value",
  "array",
  "elements",
  "id",
  "string",
  "number",
  "bool",
  "null",
  "idstart",
  "idchars",
  "idchar",
  "strchars",
  "strchar",
  "int",
  "frac",
  "exp",
  "digits",
  "e" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'parser.y', 3)
  def _reduce_1(val, _values, result)
     result = {} 
    result
  end
.,.,

# reduce 2 omitted

module_eval(<<'.,.,', 'parser.y', 6)
  def _reduce_3(val, _values, result)
     result = {} 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 7)
  def _reduce_4(val, _values, result)
     result = val[1] 
    result
  end
.,.,

# reduce 5 omitted

module_eval(<<'.,.,', 'parser.y', 10)
  def _reduce_6(val, _values, result)
     result = val[0].merge(val[2]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 12)
  def _reduce_7(val, _values, result)
     result = { val[0] => val[2] } 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 14)
  def _reduce_8(val, _values, result)
     result = [] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 15)
  def _reduce_9(val, _values, result)
     result = val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 17)
  def _reduce_10(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 18)
  def _reduce_11(val, _values, result)
     result = val[2].unshift(val[0]) 
    result
  end
.,.,

# reduce 12 omitted

# reduce 13 omitted

# reduce 14 omitted

# reduce 15 omitted

# reduce 16 omitted

# reduce 17 omitted

# reduce 18 omitted

# reduce 19 omitted

# reduce 20 omitted

module_eval(<<'.,.,', 'parser.y', 24)
  def _reduce_21(val, _values, result)
     result = true 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 25)
  def _reduce_22(val, _values, result)
     result = false 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 27)
  def _reduce_23(val, _values, result)
     result = nil 
    result
  end
.,.,

# reduce 24 omitted

module_eval(<<'.,.,', 'parser.y', 30)
  def _reduce_25(val, _values, result)
     result = val[0] + val[1] 
    result
  end
.,.,

# reduce 26 omitted

module_eval(<<'.,.,', 'parser.y', 33)
  def _reduce_27(val, _values, result)
     result = val[0] + val[1] 
    result
  end
.,.,

# reduce 28 omitted

# reduce 29 omitted

# reduce 30 omitted

# reduce 31 omitted

# reduce 32 omitted

# reduce 33 omitted

# reduce 34 omitted

# reduce 35 omitted

# reduce 36 omitted

# reduce 37 omitted

module_eval(<<'.,.,', 'parser.y', 39)
  def _reduce_38(val, _values, result)
     result = '' 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 40)
  def _reduce_39(val, _values, result)
     result = val[1] 
    result
  end
.,.,

# reduce 40 omitted

module_eval(<<'.,.,', 'parser.y', 43)
  def _reduce_41(val, _values, result)
     result = val[0] + val[1] 
    result
  end
.,.,

# reduce 42 omitted

# reduce 43 omitted

module_eval(<<'.,.,', 'parser.y', 47)
  def _reduce_44(val, _values, result)
     result = '!' 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 48)
  def _reduce_45(val, _values, result)
     result = "'" 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 50)
  def _reduce_46(val, _values, result)
     result = val[0].to_i 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 51)
  def _reduce_47(val, _values, result)
     result = "#{val[0]}#{val[1]}".to_f 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 52)
  def _reduce_48(val, _values, result)
     result = "#{val[0]}#{val[1]}".to_f 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 53)
  def _reduce_49(val, _values, result)
     result = "#{val[0]}#{val[1]}#{val[2]}".to_f 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 55)
  def _reduce_50(val, _values, result)
     result = val[0].to_i 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 56)
  def _reduce_51(val, _values, result)
     result = "#{val[0]}#{val[1]}".to_i 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 57)
  def _reduce_52(val, _values, result)
     result = "-#{val[1]}".to_i 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 58)
  def _reduce_53(val, _values, result)
     result = "-#{val[1]}#{val[2]}".to_i 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 60)
  def _reduce_54(val, _values, result)
     result = "#{val[0]}#{val[1]}" 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 62)
  def _reduce_55(val, _values, result)
     result = "#{val[0]}#{val[1]}" 
    result
  end
.,.,

# reduce 56 omitted

module_eval(<<'.,.,', 'parser.y', 65)
  def _reduce_57(val, _values, result)
     result = "#{val[0]}#{val[1]}" 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 67)
  def _reduce_58(val, _values, result)
     result = 'e' 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 68)
  def _reduce_59(val, _values, result)
     result = "e-" 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

    end   # class Parser
    end   # module Object
  end   # module Rison