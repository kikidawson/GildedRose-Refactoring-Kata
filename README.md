# Gilded Rose Refactoring Kata

This Kata was originally created by Terry Hughes (http://twitter.com/TerryHughes). It is already on GitHub [here](https://github.com/NotMyself/GildedRose). See also [Bobby Johnson's description of the kata](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/).

This is a translation from the original C# into a few other languages by Emily Bache and friends. I have chosen to do this in ruby.

## How to run the code
```
$ git clone git@github.com:kikidawson/GildedRose-Refactoring-Kata.git
$ cd GildedRose-Refactoring-Kata
$ cd ruby
$ irb -r './lib/gilded_rose.rb'
```

### How to run the tests
```
$ bundle install
$ rspec
$ rubocop
```

## Program in action

![Screenshot of IRB](./images/irb_screenshot.png)

## Planning

input => [update_quality] => output

#### standard items
- before sell by && positive quality
  ('Standard Item', 5, 10) => ('Standard Item', 4, 9)
- after sell by && positive quality
  ('Standard Item', 0, 10) => ('Standard Item', -1, 8)
- minimum quality
  ('Standard Item', 5, 0) => ('Standard Item', 4, 0)

#### sulfuras
- no sell by && always 80 quality
  ('Sulfuras, Hand of Ragnaros', 0, 80) => ('Sulfuras, Hand of Ragnaros', 0, 80)

#### aged brie
- quality under 50
  ('Aged Brie', 10, 45) => ('Aged Brie', 9, 46)
- maximum quality
  ('Aged Brie', 10, 50) => ('Aged Brie', 9, 50)

#### backstage passes
- over 10 days before event && quality under 50
  ('Backstage passes to a TAFKAL80ETC concert', 15, 10) => ('Backstage passes to a TAFKAL80ETC concert', 14, 11)
- over 10 days before event && max quality
  ('Backstage passes to a TAFKAL80ETC concert', 20, 50) => ('Backstage passes to a TAFKAL80ETC concert', 19, 50)
- 10 days before event
  ('Backstage passes to a TAFKAL80ETC concert', 10, 10) => ('Backstage passes to a TAFKAL80ETC concert', 9, 12)
- 5 days before event
  ('Backstage passes to a TAFKAL80ETC concert', 5, 10) => ('Backstage passes to a TAFKAL80ETC concert', 4, 13)
- event finished
  ('Backstage passes to a TAFKAL80ETC concert', 0, 10) => ('Backstage passes to a TAFKAL80ETC concert', -1, 0)

#### conjured items
- standard item, declines by 2 before sell by
  ('Conjured Standard Item', 10, 10) => ('Conjured Standard Item', 9, 8)
- standard item, declines by 4 after sell by
  ('Conjured Standard Item', 0, 10) => ('Conjured Standard Item', -1, 6)
- aged brie acts like normal aged brie
  ('Conjured Aged Brie', 10, 45) => ('Conjured Aged Brie', 9, 46)
- backstage passes act like normal backstage passes
  ('Conjured Backstage passes to a TAFKAL80ETC concert', 15, 10) => ('Conjured Backstage passes to a TAFKAL80ETC concert', 14, 11)
