require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    describe 'Standard Item' do
      items = [Item.new("foo", 10, 10), Item.new("bar", 0, 10), Item.new("baz", 10, 0) ]
      GildedRose.new(items).update_quality()

      it "decrease sell_in by one before sell by" do
        expect(items[0].sell_in).to eq 9
      end

      it "decrease quality by one before sell by" do
        expect(items[0].quality).to eq 9
      end

      it "decrease quality by two after sell by" do
        expect(items[1].quality).to eq 8
      end

      it 'quality doesnt drop below 0' do
        expect(items[2].quality).to eq 0
      end
    end

    describe 'Aged Brie' do
      items = [ Item.new("Aged Brie", 10, 10), Item.new("Aged Brie", 10, 50) ]
      GildedRose.new(items).update_quality()

      it 'increases in quality' do
        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 11
      end

      it 'quality never goes above 50' do
        expect(items[1].sell_in).to eq 9
        expect(items[1].quality).to eq 50
      end
    end

    describe "Sulfuras" do
      items = [ Item.new("Sulfuras, Hand of Ragnaros", 0, 80) ]
      guilded_rose = GildedRose.new(items)

      it 'never decreases in quality' do
        guilded_rose.update_quality()
        
        expect(items[0].quality).to eq 80
      end
    end

    describe "Backstage passes" do
      items = [ Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10) ]
      guilded_rose = GildedRose.new(items)

      it 'increases in quality if 11 or more days to sell' do
        guilded_rose.update_quality()

        expect(items[0].sell_in).to eq 10
        expect(items[0].quality).to eq 11
      end

      it 'increases in quality by 2 if 10 or less days to sell' do
        guilded_rose.update_quality()

        expect(items[0].sell_in).to eq 9
        expect(items[0].quality).to eq 13
      end

      it 'increases in quality by 3 if 5 or less days to sell' do
        5.times { guilded_rose.update_quality() }

        expect(items[0].sell_in).to eq 4
        expect(items[0].quality).to eq 24
      end

      it 'quality drops to 0 after event' do
        5.times { guilded_rose.update_quality() }

        expect(items[0].sell_in).to eq -1
        expect(items[0].quality).to eq 0
      end
    end
  end
end
