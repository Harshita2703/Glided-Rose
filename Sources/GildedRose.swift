
public class GildedRose {
    var items:[Item]
    
    required public init(items:[Item]) {
        self.items = items
    }
    
    public func updateQuality() {
        let itemHandler: QualityHandling = QualityHandler()
        for item in items {
            itemHandler.decreaseSellIn(item: item)
            itemHandler.updateItemQuality(item: item)
            
        }
    }
}

protocol QualityHandling {
    func updateItemQuality(item: Item)
    func decreaseSellIn(item: Item)
}

struct QualityHandler: QualityHandling {
    
    func updateItemQuality(item: Item)  {
        switch item.itemType {
        case .agedBrie, .backstage:
            updateAgedBrieAndBackStageItemQuality(item: item)
        case .sulfuras:
            break
        default:
            let decreasingFactor = item.sellIn < 0 ? 2 : 1
            item.quality = max(item.quality - decreasingFactor , 0)
        }
    }
    
    func updateAgedBrieAndBackStageItemQuality(item: Item) {
        switch item.sellIn {
        case 6...10:
            item.quality = min(item.quality + 2, 50)
        case 1...5:
            item.quality = min(item.quality + 3, 50)
        case Int.min...0:
            item.quality = 0
        default:
            item.quality = max(item.quality - 1, 0)
        }
    }
    
    func decreaseSellIn(item: Item) {
        switch item.itemType {
        case .sulfuras:
            break
        default:
            item.sellIn -= 1
        }
    }
}

