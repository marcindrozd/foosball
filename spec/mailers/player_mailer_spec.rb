require "spec_helper"

describe PlayerMailer do
  describe "send_challenge" do
    let(:mail) { PlayerMailer.send_challenge }

    it "renders the headers" do
      mail.subject.should eq("Send challenge")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
