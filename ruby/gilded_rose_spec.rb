require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  before(:each) do
    @items = [
      Item.new("Standard Item", 5, 10),
      Item.new("Standard Item", 0, 10),
      Item.new("Standard Item", 5, 0),
      Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
      Item.new("Aged Brie", 10, 45),
      Item.new("Aged Brie", 10, 50),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 50),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10),
      Item.new("Conjured Standard Item", 10, 10),
      Item.new("Conjured Standard Item", 0, 10),
      Item.new("Conjured Aged Brie", 10, 45),
      Item.new("Conjured Backstage passes to a TAFKAL80ETC concert", 15, 10),
    ]
    gilded_rose = GildedRose.new(@items)
    gilded_rose.update_quality()
  end

  describe "#update_quality" do

    describe 'Standard Item' do

      it "does not change the name" do
        expect(@items[0].name).to eq "Standard Item"
      end

      it "decrease sell_in and quality by one before sell by" do
        expect(@items[0].sell_in).to eq 4
        expect(@items[0].quality).to eq 9
      end

      it "decrease quality by two after sell by" do
        expect(@items[1].sell_in).to eq(-1)
        expect(@items[1].quality).to eq 8
      end

      it 'quality doesnt drop below 0' do
        expect(@items[2].sell_in).to eq 4
        expect(@items[2].quality).to eq 0
      end
    end

    describe "Sulfuras" do

      it 'never decreases in quality' do
        expect(@items[3].sell_in).to eq 0
        expect(@items[3].quality).to eq 80
      end
    end

    describe 'Aged Brie' do

      it 'increases in quality' do
        expect(@items[4].sell_in).to eq 9
        expect(@items[4].quality).to eq 46
      end

      it 'quality never goes above 50' do
        expect(@items[5].sell_in).to eq 9
        expect(@items[5].quality).to eq 50
      end
    end

    describe "Backstage passes" do

      it 'increases in quality if 11 or more days to sell' do
        expect(@items[6].sell_in).to eq 14
        expect(@items[6].quality).to eq 11
      end

      it 'quality never goes above 50' do
        expect(@items[7].sell_in).to eq 19
        expect(@items[7].quality).to eq 50
      end

      it 'increases in quality by 2 if 10 or less days to sell' do
        expect(@items[8].sell_in).to eq 9
        expect(@items[8].quality).to eq 12
      end

      it 'increases in quality by 3 if 5 or less days to sell' do
        expect(@items[9].sell_in).to eq 4
        expect(@items[9].quality).to eq 13
      end

      it 'quality drops to 0 after event' do
        expect(@items[10].sell_in).to eq -1
        expect(@items[10].quality).to eq 0
      end
    end

    describe 'Conjured items' do
      it 'degrades in quality by 2 before sell by' do
        expect(@items[11].sell_in).to eq 9
        expect(@items[11].quality).to eq 8
      end

      it 'degrades in quality by 4 after sell by' do
        expect(@items[12].sell_in).to eq -1
        expect(@items[12].quality).to eq 6
      end

      it 'conjured aged brie like normal aged brie' do
        expect(@items[13].sell_in).to eq 9
        expect(@items[13].quality).to eq 46
      end

      it 'conjured backstage passes like normal backstage passes' do
        expect(@items[14].sell_in).to eq 14
        expect(@items[14].quality).to eq 11
      end
    end
  end
end
