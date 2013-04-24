require 'spec_helper'

describe Score do
  it { should belong_to :leaderboard }
  it { should belong_to :user }

  let(:leaderboard) { FactoryGirl.create(:leaderboard) }

  context ".sort_by_value" do
    before do
      @score1 = FactoryGirl.create(:score, value: 10)
      @score2 = FactoryGirl.create(:score, value: 5)
      @score3 = FactoryGirl.create(:score, value: 15)
    end

    it "gets scores" do
      expect(Score.sort_by_value).to eq [@score3, @score1, @score2]
    end
  end

  context ".page" do
    before do
      Score.send(:remove_const, :PER_PAGE)
      Score.const_set(:PER_PAGE, 2)
      @score1 = FactoryGirl.create(:score)
      @score2 = FactoryGirl.create(:score)
      @score3 = FactoryGirl.create(:score)
    end

    it "gets first 2 scores" do
      expect(Score.page(1)).to eq [@score1, @score2]
    end

    it "gets last score" do
      expect(Score.page(2)).to eq [@score3]
    end
  end
end
