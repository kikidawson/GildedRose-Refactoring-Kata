class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      update_sell_in_and_quality(item) unless sulfuras?(item)
    end
  end

  private

  def update_sell_in_and_quality(item)
    item.sell_in -= 1
    change_quality_if_between_zero_and_fifty(item)
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def update_quality_of_aged_brie(item)
    plus_quality(item)
  end

  def update_quality_of_backstage_passes(item)
    return item.quality = 0 if sell_in(item, 0)
    plus_quality(item)
    plus_quality(item) if sell_in(item, 10)
    plus_quality(item) if sell_in(item, 5)
  end

  def update_quality_of_standard_item(item)
    minus_quality(item)
    minus_quality(item) if sell_in(item, 0)
  end

  def find_logic(item)
    case item.name
    when "Aged Brie"
      update_quality_of_aged_brie(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      update_quality_of_backstage_passes(item)
    else
      update_quality_of_standard_item(item)
    end
  end

  def sell_in(item, days)
    item.sell_in < days
  end

  def minus_quality(item)
    item.quality -= 1
  end

  def plus_quality(item)
    item.quality += 1
  end

  def change_quality_if_between_zero_and_fifty(item)
    find_logic(item) if quality_between_zero_and_fifty?(item)
  end

  def quality_between_zero_and_fifty?(item)
    item.quality.between?(1, 49)
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
