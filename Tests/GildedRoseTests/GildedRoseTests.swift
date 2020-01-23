import Foundation
import XCTest

@testable import GildedRose

class GildedRoseTests: XCTestCase {
    var sulfurasItem: Item?
    var defaultItem: Item?
    var agedBrie: Item?
    
    override func setUp() {
        super.setUp()
        sulfurasItem = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 0, quality: 80)
        defaultItem = Item(name: "Conjured Mana Cake", sellIn: 3, quality: 6)
        agedBrie = Item(name: "Aged Brie", sellIn: 2, quality: 0)
    }
    
    func testSulfuras() {
        let app = GildedRose(items: [sulfurasItem!])
        app.updateQuality()
        let sulfuras = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 0, quality: 80)
        XCTAssertEqual(sulfuras, sulfurasItem!)
    }
    
    func testDefaultItem() {
        let app = GildedRose(items: [defaultItem!])
        let sellIn = defaultItem!.sellIn - 1
        let decreasingFactor = sellIn < 0 ? 2 : 1
        let quality = defaultItem!.quality - decreasingFactor
        app.updateQuality()
        XCTAssertEqual(sellIn, defaultItem!.sellIn)
        XCTAssertEqual(quality, defaultItem!.quality)
        XCTAssertTrue(defaultItem!.quality >= 0 && defaultItem!.quality <= 50)
    }
    
    func testAgedBrieItem() {
        let app = GildedRose(items: [agedBrie!])
        let sellIn = agedBrie!.sellIn - 1
        var quality = agedBrie!.quality
        app.updateQuality()
        switch sellIn {
        case 6...10:
            quality = min(quality + 2, 50)
        case 1...5:
            quality = min(quality + 3, 50)
        case Int.min...0:
            quality = 0
        default:
            quality = max(quality - 1, 0)
        }
        XCTAssertEqual(sellIn, agedBrie!.sellIn)
        XCTAssertEqual(quality, agedBrie!.quality)
        XCTAssertTrue(agedBrie!.quality >= 0 && agedBrie!.quality <= 50)
    }
}

#if os(Linux)
extension GildedRoseTests {
    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testFoo", testFoo),
        ]
    }
}
#endif
