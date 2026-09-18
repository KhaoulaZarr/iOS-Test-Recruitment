//
//  JsonMapperTests.swift
//  TheGoodCornerTests
//
//  Created by Khawla Zarrami on 18/09/2026.
//

import XCTest
@testable import TheGoodCorner

@MainActor
final class JsonMapperTests: XCTestCase {
    
    func test_with_valid_json_successfully_decodes()  {
        XCTAssertNoThrow(try StaticJsonMapper.decode(file: "ListingsStaticData", type: ListingFeed.self), "Mapper shouldn't throw an error")
        let listingFeed = try? StaticJsonMapper.decode(file: "ListingsStaticData", type: ListingFeed.self)
        XCTAssertNotNil(listingFeed, "Listing response should not be nil")
        XCTAssertEqual(listingFeed?.page, 1, "Page number should be 1")
        XCTAssertEqual(listingFeed?.limit, 5, "Limit should be 6")
        XCTAssertEqual(listingFeed?.total,300,"Total number of listings should be 300")
        XCTAssertEqual(listingFeed?.hasMore,true,"has_more should be true")
        XCTAssertEqual(listingFeed?.items.count, 5, "The total number of listings should be 5")
        // 1
        XCTAssertEqual(listingFeed?.items[0].id, 1547408955, "The first listing ID should be 1547408955")
        XCTAssertEqual(listingFeed?.items[0].isUrgent, true, "the is_urgent should be true")
        XCTAssertEqual(listingFeed?.items[0].categoryId, 7, "the category_id should be 7")
        XCTAssertEqual(listingFeed?.items[0].title, "Vinyle Elliott Murphy Just A Story From America", "The title should match")
        XCTAssertEqual(listingFeed?.items[0].price, 10, "The price should be 10")
        
        // 2
        XCTAssertEqual(listingFeed?.items[1].id, 1702202101, "The second listing ID should be 1702202101")
        XCTAssertEqual(listingFeed?.items[1].isUrgent, true, "the is_urgent should be true")
        XCTAssertEqual(listingFeed?.items[1].categoryId, 11, "the category_id should be 11")
        XCTAssertEqual(listingFeed?.items[1].title, "Poussette Bugaboo Bee", "The title should match")
        XCTAssertEqual(listingFeed?.items[1].price, 250, "The price should be 250")
        
        // 3
        XCTAssertEqual(listingFeed?.items[2].id, 1547403749, "The third listing ID should be 1547403749")
        XCTAssertEqual(listingFeed?.items[2].isUrgent, true, "the is_urgent should be true")
        XCTAssertEqual(listingFeed?.items[2].categoryId, 7, "the category_id should be 7")
        XCTAssertEqual(listingFeed?.items[2].title, "Vinyle Lalo Schifrin Mission: Impossible", "The title should match")
        XCTAssertEqual(listingFeed?.items[2].price, 10, "The price should be 10")
        
        // 4
        XCTAssertEqual(listingFeed?.items[3].id, 1702201647, "The fourth listing ID should be 1702201647")
        XCTAssertEqual(listingFeed?.items[3].isUrgent, true, "the is_urgent should be true")
        XCTAssertEqual(listingFeed?.items[3].categoryId, 4, "the category_id should be 4")
        XCTAssertEqual(listingFeed?.items[3].title, "Brosse à dent électrique 2 en 1 NEUVE Hybrid", "The title should match")
        XCTAssertEqual(listingFeed?.items[3].price, 25, "The price should be 25")
        
        // 5
        XCTAssertEqual(listingFeed?.items[4].id, 1702201512, "The fifth listing ID should be 1702201512")
        XCTAssertEqual(listingFeed?.items[4].isUrgent, true, "the is_urgent should be true")
        XCTAssertEqual(listingFeed?.items[4].categoryId, 7, "the category_id should be 7")
        XCTAssertEqual(listingFeed?.items[4].title, "Les morts du Karst de Veit Heinichen", "The title should match")
        XCTAssertEqual(listingFeed?.items[4].price, 3, "The price should be 3")
        
    }
    
    func test_with_missing_file_error_thrown() {
        XCTAssertThrowsError(try StaticJsonMapper.decode(file: "", type: ListingFeed.self),"An error should be thrown")
        do {
            _ = try StaticJsonMapper.decode(file: "", type: ListingFeed.self)
        }catch {
            guard let mappingError = error as? StaticJsonMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(mappingError, StaticJsonMapper.MappingError.failedToGetContents, "This should be failed to get content error")
        }
        
    }
    
    func test_with_invalid_file_thrown() {
        XCTAssertThrowsError(try StaticJsonMapper.decode(file: "dfddfff", type: ListingFeed.self), "An error should be thrown")
        do {
            _ = try StaticJsonMapper.decode(file: "dfdfffd", type: ListingFeed.self)
        } catch {
            guard let mappingError = error as? StaticJsonMapper.MappingError else {
                XCTFail("This is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(mappingError, StaticJsonMapper.MappingError.failedToGetContents, "This should be failed to get content error")
            
        }
    }
    
    func test_with_invalid_json_error_thrown() {
        XCTAssertThrowsError(try StaticJsonMapper.decode(file: "ListingsStaticData", type: Listing.self), "An error should be thrown")
        do {
            _ = try StaticJsonMapper.decode(file: "ListingsStaticData", type: Listing.self)
        } catch {
            if error is StaticJsonMapper.MappingError {
                XCTFail("Got the wrong type of error, expecting a system decoding error")
            }
        }
    }
}
