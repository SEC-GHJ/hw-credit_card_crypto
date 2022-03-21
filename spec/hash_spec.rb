# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

cards = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      cards.each do |test|
        describe "The user of the card is #{test.owner} and the bank of the card is #{test.credit_network}" do
          it 'should produce same hash if hashed repeatedly' do
            # Repeat three times
            hash_arr = (1..3).map { test.hash }
            # Check the hash result isn't nil
            _(hash_arr.any?(&:nil?)).must_equal false
            # Check the hash element are the same
            _(hash_arr.uniq.size.to_s).must_equal 1.to_s
          end
        end
      end
    end
    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      test_hashes = cards.map(&:hash)
      it 'produce different hash when the input serialize content is not the same' do
        _(test_hashes.any?(&:nil?)).must_equal false
        _(test_hashes.uniq.size.to_s).must_equal test_hashes.length.to_s
      end
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      cards.each do |test|
        describe "The user of the card is #{test.owner} and the bank of the card is #{test.credit_network}" do
          # TODO: Check that each card produces the same hash if hashed repeatedly
          it 'produces the same hash if hashed repeatedly' do
            hash_arr = (1...3).map { test.hash_secure }
            _(hash_arr.any?(&:nil?)).must_equal false
            _(hash_arr.uniq.size.to_s).must_equal 1.to_s
          end
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      test_hashes = cards.map(&:hash_secure)
      it 'produces a different hash than other cards' do
        _(test_hashes.any?(&:nil?)).must_equal false
        _(test_hashes.uniq.size.to_s).must_equal test_hashes.length.to_s
      end
    end

    describe 'Check regular hash not same as cryptographic hash' do
      # TODO: Check that each card's hash is different from its hash_secure
      it 'each card hash is different from its hash_secure' do
        reg_hash = cards.map(&:hash)
        cryp_hash = cards.map(&:hash_secure)
        _(reg_hash).wont_equal nil
        _(cryp_hash).wont_equal nil
        _(reg_hash).wont_equal cryp_hash
      end
    end
  end
end
