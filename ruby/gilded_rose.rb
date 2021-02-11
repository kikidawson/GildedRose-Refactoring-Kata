class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in -= 1
        change_quality_if_between_zero_and_fifty(item)
      end
    end
  end

  private

  def aged_brie_logic(item)
    item.quality += 1
  end

  def backstage_passes_logic(item)
    return item.quality = 0 if past_sell_by(item)
    item.quality += 1
    item.quality += 1 if item.sell_in < 10
    item.quality += 1 if item.sell_in < 5
  end

  def standard_item_logic(item)
    item.quality -= 1
    item.quality -= 1 if past_sell_by(item)
  end

  def find_logic(item)
    if item.name == "Aged Brie"
      aged_brie_logic(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      backstage_passes_logic(item)
    else
      standard_item_logic(item)
    end
  end

  def past_sell_by(item)
    item.sell_in < 0
  end

  def change_quality_if_between_zero_and_fifty(item)
    find_logic(item) if item.quality.between?(1, 49)
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
