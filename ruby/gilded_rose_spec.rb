require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do

    describe 'Standard Item' do
      items = [ Item.new("Standard Item", 4, 10) ]
      guilded_rose = GildedRose.new(items)
      standard_item = items[0]

      it "decrease sell_in and quality by one before sell by" do
        guilded_rose.update_quality()

        expect(standard_item.sell_in).to eq 3
        expect(standard_item.quality).to eq 9
      end

      it "decrease quality by two after sell by" do
        4.times { guilded_rose.update_quality() }

        expect(standard_item.sell_in).to eq -1
        expect(standard_item.quality).to eq 4
      end

      it 'quality doesnt drop below 0' do
        3.times { guilded_rose.update_quality() }

        expect(standard_item.sell_in).to eq -4
        expect(standard_item.quality).to eq 0
      end

      it "does not change the name" do
        expect(standard_item.name).to eq "Standard Item"
      end
    end

    describe 'Aged Brie' do
      items = [ Item.new("Aged Brie", 10, 45) ]
      guilded_rose = GildedRose.new(items)
      aged_brie = items[0]

      it 'increases in quality' do
        guilded_rose.update_quality()

        expect(aged_brie.sell_in).to eq 9
        expect(aged_brie.quality).to eq 46
      end

      it 'quality never goes above 50' do
        5.times { guilded_rose.update_quality() }

        expect(aged_brie.sell_in).to eq 4
        expect(aged_brie.quality).to eq 50
      end
    end

    describe "Sulfuras" do
      items = [ Item.new("Sulfuras, Hand of Ragnaros", 0, 80) ]
      guilded_rose = GildedRose.new(items)
      sulfuras = items[0]

      it 'never decreases in quality' do
        guilded_rose.update_quality()

        expect(sulfuras.sell_in).to eq 0
        expect(sulfuras.quality).to eq 80
      end
    end

    describe "Backstage passes" do
      items = [
        Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)
      ]
      guilded_rose = GildedRose.new(items)
      backstage_passes = items[0]
      quality_backstage = items[1]

      it 'quality never goes above 50' do
        guilded_rose.update_quality()

        expect(quality_backstage.sell_in).to eq 10
        expect(quality_backstage.quality).to eq 50
      end

      it 'increases in quality if 11 or more days to sell' do
        expect(backstage_passes.sell_in).to eq 10
        expect(backstage_passes.quality).to eq 11
      end

      it 'increases in quality by 2 if 10 or less days to sell' do
        guilded_rose.update_quality()

        expect(backstage_passes.sell_in).to eq 9
        expect(backstage_passes.quality).to eq 13
      end

      it 'increases in quality by 3 if 5 or less days to sell' do
        5.times { guilded_rose.update_quality() }

        expect(backstage_passes.sell_in).to eq 4
        expect(backstage_passes.quality).to eq 24
      end

      it 'quality drops to 0 after event' do
        5.times { guilded_rose.update_quality() }

        expect(backstage_passes.sell_in).to eq -1
        expect(backstage_passes.quality).to eq 0
      end
    end
  end
end
