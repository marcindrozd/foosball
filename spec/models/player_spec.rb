require 'spec_helper'

describe Player do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should have_many(:host_matches).class_name('Match').with_foreign_key(:player1_id) }
  it { should have_many(:guest_matches).class_name('Match').with_foreign_key(:player2_id) }

  describe "#full_name" do
    it "returns full name of the player" do
      alice = create(:player, first_name: "Alice", last_name: "Angel")
      expect(alice.full_name).to eq("Alice Angel")
    end
  end
end
