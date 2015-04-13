require "spec_helper"

describe PlayerMailer do
  describe "send_challenge" do
    let(:alice) { create(:player, email: "alice@example.com") }
    let(:bob) { create(:player, email: "bob@example.com") }
    let(:mail) { PlayerMailer.send_challenge(bob, alice, "Let's play!") }

    it "renders the headers" do
      expect(mail.subject).to eq("You have been challenged!")
      expect(mail.to).to eq(["alice@example.com"])
      expect(mail.from).to eq(["bob@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Let's play!")
    end
  end

end
