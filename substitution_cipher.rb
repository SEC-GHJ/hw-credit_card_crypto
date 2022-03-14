# frozen_string_literal: true

module SubstitutionCipher
  # Caesar encrypt and decrypt
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      number = document.to_s.split('')
      result = number.map do |num|
        ((num.ord + key) % 128).chr
      end
      result.join('')
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      number = document.to_s.split('')
      result = number.map do |num|
        ((num.ord + 128 - key) % 128).chr
      end
      result.join('')
    end
  end

  # Permutation encrypt and decrypt
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      chars = document.to_s.split('')
      # Create lookup table of characters
      table_ord = (0..127).to_a.map(&:chr)
      # Create lookup table by shuffling with the key
      table_shuf = table_ord.shuffle(random: Random.new(key))
      # Get a lookup table
      table_lookup = Hash[table_ord.zip(table_shuf)]
      # Encrype the array by the look up table
      encrypt_arr = chars.map do |char|
        table_lookup[char]
      end
      encrypt_arr.join('')
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      de_chars = document.to_s.split('')
      # Create lookup table of characters
      table_ord = (0..127).to_a.map(&:chr)
      # Create lookup table by shuffling with the key
      table_shuf = table_ord.shuffle(random: Random.new(key))
      # Get a reverse lookup table
      table_lookup_rev = Hash[table_shuf.zip(table_ord)]
      # decrype the array by the look up table
      decrypt_arr = de_chars.map do |char|
        table_lookup_rev[char]
      end
      decrypt_arr.join('')
    end
  end
end
