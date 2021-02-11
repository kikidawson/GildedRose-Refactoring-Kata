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

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def update_sell_in_and_quality(item)
    item.sell_in -= 1
    update_quality_of(item) if item.quality.between?(1, 49)
  end

  def update_quality_of(item)
    if aged_brie?(item) || conjured_aged_brie?(item)
      update_quality_of_aged_brie(item)
    elsif backstage_passes?(item) || conjured_backstage_passes?(item)
      update_quality_of_backstage_passes(item)
    else
      update_quality_of_standard_item(item)
    end
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def conjured_aged_brie?(item)
    item.name == "Conjured Aged Brie"
  end

  def backstage_passes?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def conjured_backstage_passes?(item)
    item.name == "Conjured Backstage passes to a TAFKAL80ETC concert"
  end

  def conjured?(item)
    item.name.start_with?("Conjured ")
  end

  def update_quality_of_aged_brie(item)
    plus_quality(item)
  end

  def update_quality_of_backstage_passes(item)
    return item.quality = 0 if days_until_sell_by(item, 0)
    plus_quality(item)
    plus_quality(item) if days_until_sell_by(item, 10)
    plus_quality(item) if days_until_sell_by(item, 5)
  end

  def update_quality_of_standard_item(item)
    minus_quality(item, 1)
    minus_quality(item, 1) if days_until_sell_by(item, 0)
    update_quality_of_conjured(item) if conjured?(item)
  end

  def update_quality_of_conjured(item)
    minus_quality(item, 1)
    minus_quality(item, 1) if days_until_sell_by(item, 0)
  end

  def days_until_sell_by(item, days)
    item.sell_in < days
  end

  def minus_quality(item, quality_points)
    item.quality -= quality_points
  end

  def plus_quality(item)
    item.quality += 1
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
