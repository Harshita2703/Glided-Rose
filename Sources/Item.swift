
public class Item {
    public var name: String
    public var sellIn: Int
    public var quality: Int
    
    public init(name: String, sellIn: Int, quality: Int) {
        self.name = name
        self.sellIn = sellIn
        self.quality = quality
    }
}

extension Item: CustomStringConvertible {
    public var description: String {
        return self.name + ", " + String(self.sellIn) + ", " + String(self.quality);
    }
}

extension Item: Equatable {
     var itemType: ItemType {
        return ItemType(rawValue: self.name) ?? .none
    }

    public static func == (lhs: Item, rhs: Item) -> Bool {
        return (lhs.name == rhs.name && lhs.sellIn == rhs.sellIn && lhs.quality == rhs.quality)
    }
}


enum ItemType: String {
    case dexterity = "+5 Dexterity Vest"
    case agedBrie = "Aged Brie"
    case mongoose = "Elixir of the Mongoose"
    case sulfuras = "Sulfuras, Hand of Ragnaros"
    case backstage = "Backstage passes to a TAFKAL80ETC concert"
    case conjured = "Conjured Mana Cake"
    case none = ""
}
