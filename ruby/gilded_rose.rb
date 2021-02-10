class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      find_logic(item)
    end
  end

  private

  def maximum_quality?(item)
    item.quality == 50
  end

  def minimum_quality?(item)
    item.quality == 0
  end

  def aged_brie_logic(item)
    if !maximum_quality?(item)
      item.quality += 1
    end
    item.sell_in -= 1
  end

  def backstage_passes_logic(item)
    if !maximum_quality?(item)
      if item.sell_in < 1
        item.quality = 0
      elsif item.sell_in < 6
        item.quality += 3
      elsif item.sell_in < 11
        item.quality += 2
      else
        item.quality += 1
      end
    end
    item.sell_in -= 1
  end

  def standard_item_logic(item)
    if item.sell_in > 0
      item.quality -= 1
    elsif item.sell_in <= 0
      if !minimum_quality?(item)
        item.quality -= 2
      end
    end
    item.sell_in -= 1
  end

  def find_logic(item)
    case item.name
    when "Sulfuras, Hand of Ragnaros"
    when "Aged Brie"
      aged_brie_logic(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      backstage_passes_logic(item)
    else
      standard_item_logic(item)
    end
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
