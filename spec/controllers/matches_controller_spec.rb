require 'spec_helper'

describe MatchesController do
  describe "GET new" do
    it "creates Match object" do
      get :new
      expect(assigns(:match)).to be_instance_of(Match)
    end
  end
end
