require "spec_helper"

describe PlayerMailer do
  describe "send_challenge" do
    let(:alice) { create(:player, email: "alice@example.com") }
    let(:bob) { create(:player, email: "bob@example.com") }
    let(:mail) { PlayerMailer.send_challenge(bob, alice, "Let's play!") }

    it "renders the headers" do
      mail.subject.should eq("You have been challenged!")
      mail.to.should eq(["alice@example.com"])
      mail.from.should eq(["bob@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Let's play!")
    end
  end

end
