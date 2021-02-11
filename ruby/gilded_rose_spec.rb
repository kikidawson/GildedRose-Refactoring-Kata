require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do

    describe 'Standard Item' do
      before(:each) do
        items = [ Item.new("Standard Item", 4, 10) ]
        @guilded_rose = GildedRose.new(items)
        @standard_item = items[0]
      end

      it "decrease sell_in and quality by one before sell by" do
        @guilded_rose.update_quality()

        expect(@standard_item.sell_in).to eq 3
        expect(@standard_item.quality).to eq 9
      end

      it "decrease quality by two after sell by" do
        5.times { @guilded_rose.update_quality() }

        expect(@standard_item.sell_in).to eq -1
        expect(@standard_item.quality).to eq 4
      end

      it 'quality doesnt drop below 0' do
        8.times { @guilded_rose.update_quality() }

        expect(@standard_item.sell_in).to eq -4
        expect(@standard_item.quality).to eq 0
      end

      it "does not change the name" do
        expect(@standard_item.name).to eq "Standard Item"
      end
    end

    describe 'Aged Brie' do
      before(:each) do
        items = [ Item.new("Aged Brie", 10, 45) ]
        @guilded_rose = GildedRose.new(items)
        @aged_brie = items[0]
      end

      it 'increases in quality' do
        @guilded_rose.update_quality()

        expect(@aged_brie.sell_in).to eq 9
        expect(@aged_brie.quality).to eq 46
      end

      it 'quality never goes above 50' do
        6.times { @guilded_rose.update_quality() }

        expect(@aged_brie.sell_in).to eq 4
        expect(@aged_brie.quality).to eq 50
      end
    end

    describe "Sulfuras" do
      before(:each) do
        items = [ Item.new("Sulfuras, Hand of Ragnaros", 0, 80) ]
        @guilded_rose = GildedRose.new(items)
        @sulfuras = items[0]
      end

      it 'never decreases in quality' do
        @guilded_rose.update_quality()

        expect(@sulfuras.sell_in).to eq 0
        expect(@sulfuras.quality).to eq 80
      end
    end

    describe "Backstage passes" do
      before(:each) do
        items = [
          Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10),
          Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)
        ]
        @guilded_rose = GildedRose.new(items)
        @backstage_passes = items[0]
        @quality_backstage = items[1]
      end

      it 'quality never goes above 50' do
        @guilded_rose.update_quality()

        expect(@quality_backstage.sell_in).to eq 10
        expect(@quality_backstage.quality).to eq 50
      end

      it 'increases in quality if 11 or more days to sell' do
        @guilded_rose.update_quality()

        expect(@backstage_passes.sell_in).to eq 10
        expect(@backstage_passes.quality).to eq 11
      end

      it 'increases in quality by 2 if 10 or less days to sell' do
        2.times { @guilded_rose.update_quality() }

        expect(@backstage_passes.sell_in).to eq 9
        expect(@backstage_passes.quality).to eq 13
      end

      it 'increases in quality by 3 if 5 or less days to sell' do
        7.times { @guilded_rose.update_quality() }

        expect(@backstage_passes.sell_in).to eq 4
        expect(@backstage_passes.quality).to eq 24
      end

      it 'quality drops to 0 after event' do
        12.times { @guilded_rose.update_quality() }

        expect(@backstage_passes.sell_in).to eq -1
        expect(@backstage_passes.quality).to eq 0
      end
    end

    describe 'Mutliple items provided' do
      items = [
        Item.new("Standard Item", 5, 10),
        Item.new("Standard Item", 0, 10),
        Item.new("Standard Item", 5, 0),
        Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
        Item.new("Aged Brie", 10, 45),
        Item.new("Aged Brie", 10, 50),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 50),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)
      ]
      guilded_rose = GildedRose.new(items)
      guilded_rose.update_quality()

      it "works when multiple items provided" do
        expect(items[1].quality).to eq 8
        expect(items[2].quality).to eq 0
        expect(items[3].quality).to eq 80
        expect(items[4].quality).to eq 46
        expect(items[5].quality).to eq 50
        expect(items[6].quality).to eq 50
        expect(items[7].quality).to eq 12
        expect(items[8].quality).to eq 13
        expect(items[9].quality).to eq 0
      end
    end
  end
end
