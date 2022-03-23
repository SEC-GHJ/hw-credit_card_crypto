# frozen_string_literal: true

require_relative 'credit_card'

# double transposition - switch rows and cols
module DoubleTranspositionCipher
  def self.generate_matrix(str)
    len = str.length
    cols = Math.sqrt(len).floor
    rows = (len % cols).zero? ? cols : cols + 1

    arr = Array.new(rows) { Array.new(cols) { '_' } }
    str.chars.each_with_index do |chr, index|
      arr[index / cols][index % cols] = chr
    end

    arr
  end

  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    arr = generate_matrix(document.to_s)

    # 3. sort rows in predictibly random way using key as seed
    row_swap_arr = arr.shuffle(random: Random.new(key))

    # 4. sort columns of each row in predictibly random way
    col_swap_arr = row_swap_arr.transpose.shuffle(random: Random.new(key))

    # 5. return joined cyphertext
    col_swap_arr.transpose.reduce(&:+).reduce(&:+)
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    # generate matrix format
    arr = generate_matrix(ciphertext)

    # swap col first
    col_swap_arr = arr.transpose.unshuffle(random: Random.new(key))

    # swap row
    row_swap_arr = col_swap_arr.transpose.unshuffle(random: Random.new(key))
    row_swap_arr.reduce(&:+).reduce(&:+)
  end
end

# extend array obj
class Array
  def unshuffle(random:)
    transformed_order = (0...length).to_a.shuffle!(random: random)
    sort_by.with_index { |_, i| transformed_order[i] }
  end
end
