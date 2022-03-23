# frozen_string_literal: true

require 'base64'
require 'rbnacl'

# Symmetric cipher
module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)

    Base64.strict_encode64(key)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    key = Base64.strict_decode64(key)
    secret_box = RbNaCl::SecretBox.new(key)
    # nonce isn't secret, and can be sent with the ciphertext
    nonce = RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
    cipher = secret_box.encrypt(nonce, document.to_s)

    # return ciphertexet with the nonce
    [Base64.strict_encode64(nonce), Base64.strict_encode64(cipher)]
  end

  def self.decrypt(encrypted_cc, nonce, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    nonce = Base64.strict_decode64(nonce)
    cipher = Base64.strict_decode64(encrypted_cc)
    key = Base64.strict_decode64(key)
    secret_box = RbNaCl::SecretBox.new(key)

    secret_box.decrypt(nonce, cipher)
  end
end
