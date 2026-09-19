//
//  ListingViewModelSuccessTests.swift
//  TheGoodCornerTests
//
//  Created by Khawla Zarrami on 19/09/2026.
//

import XCTest
@testable import TheGoodCorner

@MainActor
final class ListingViewModelSuccessTests: XCTestCase {
    private var listingServiceMock: ListingServiceProtocol!
    private var categoryServiceMock: CategoryServiceProtocol!
    private var vm: ListingViewModel!
    

    override func setUp() {
        listingServiceMock = ListingServiceSuccessMock()
        categoryServiceMock = CategoryServiceSuccessMock()
        vm = ListingViewModel(listingService: listingServiceMock, categoryService: categoryServiceMock)
    }
    
    override func tearDown() {
        listingServiceMock = nil
        categoryServiceMock = nil
        vm = nil
    }
    // When the server returns a successful response, does the ViewModel correctly map category IDs to category names?
    
    func test_with_successful_response_category_id_is_mapped_to_category_name()  async throws{
        
        XCTAssertEqual(vm.loadingState , .idle, "The initial state should be idle")
        defer {
            if  case .loaded(let listings) = vm.loadingState {
                XCTAssertFalse(listings.isEmpty,"The listings array should not be empty")
                XCTAssertEqual(listings.count,5, "There should be 5 listings within our data array")
            } else {
                XCTFail("The state should be loaded")
            }
            
            XCTAssertEqual(vm.categories.count,11, "There should be 11 categories within our data array")
        }
        await vm.loadListings()
        XCTAssertEqual(
            vm.categoryName(for: 1),
            "Véhicule",
            "Category ID 1 should be mapped to Véhicule"
        )
        
        XCTAssertEqual(
            vm.categoryName(for: 2),
            "Mode",
            "Category ID 2 should be mapped to Mode"
        )
        XCTAssertEqual(
            vm.categoryName(for: 3),
            "Bricolage",
            "Category ID 3 should be mapped to Bricolage"
        )
        
        XCTAssertEqual(
            vm.categoryName(for: 4),
            "Maison",
            "Category ID 4 should be mapped to Maison"
        )
        
        XCTAssertEqual(
            vm.categoryName(for: 5),
            "Loisirs",
            "Category ID 5 should be mapped to Loisirs"
        )
        XCTAssertEqual(
            vm.categoryName(for: 6),
            "Immobilier",
            "Category ID 6 should be mapped to Immobilier"
        )
        XCTAssertEqual(
            vm.categoryName(for: 7),
            "Livres/CD/DVD",
            "Category ID 7 should be mapped to Livres/CD/DVD"
        )
        XCTAssertEqual(
            vm.categoryName(for: 8),
            "Multimédia",
            "Category ID 8 should be mapped to Multimédia"
        )
        XCTAssertEqual(
            vm.categoryName(for: 9),
            "Service",
            "Category ID 9 should be mapped to Service"
        )
        XCTAssertEqual(
            vm.categoryName(for: 10),
            "Animaux",
            "Category ID 10 should be mapped to Animaux"
        )
        XCTAssertEqual(
            vm.categoryName(for: 11),
            "Enfants",
            "Category ID 11 should be mapped to Enfants"
        )
    }
    
    // When a category ID is selected, does the ViewModel return only the listings matching that category?
    func test_filter_by_category_returns_matching_listings() async throws {
        let categoryId = 7
        await vm.loadListings()
        vm.filterByCategory(categoryId)
        if case .loaded(let listings)  = vm.loadingState {
            XCTAssertTrue(
                listings.allSatisfy { $0.categoryId == categoryId },
                "All listings should belong to category 7"
            )
            XCTAssertEqual(listings.count, 3, "There should be 3 listings with category id 7")
            // First listing
            XCTAssertEqual(
                listings[0].id,
                1547408955,
                "The first filtered listing ID should be 1547408955"
            )
            
            XCTAssertEqual(
                listings[0].isUrgent,
                true,
                "The is_urgent should be true"
            )
            
            XCTAssertEqual(
                listings[0].categoryId,
                7,
                "The category_id should be 7"
            )
            
            XCTAssertEqual(
                listings[0].title,
                "Vinyle Elliott Murphy Just A Story From America",
                "The title should match"
            )
            
            XCTAssertEqual(
                listings[0].price,
                10,
                "The price should be 10"
            )
            
            // Second listing
            XCTAssertEqual(
                listings[1].id,
                1547403749,
                "The second filtered listing ID should be 1547403749"
            )
            
            XCTAssertEqual(
                listings[1].isUrgent,
                true,
                "The is_urgent should be true"
            )
            
            XCTAssertEqual(
                listings[1].categoryId,
                7,
                "The category_id should be 7"
            )
            
            XCTAssertEqual(
                listings[1].title,
                "Vinyle Lalo Schifrin Mission: Impossible",
                "The title should match"
            )
            
            XCTAssertEqual(
                listings[1].price,
                10,
                "The price should be 10"
            )
            
            // Third listing
            XCTAssertEqual(
                listings[2].id,
                1702201512,
                "The third filtered listing ID should be 1702201512"
            )
            
            XCTAssertEqual(
                listings[2].isUrgent,
                true,
                "The is_urgent should be true"
            )
            
            XCTAssertEqual(
                listings[2].categoryId,
                7,
                "The category_id should be 7"
            )
            
            XCTAssertEqual(
                listings[2].title,
                "Les morts du Karst de Veit Heinichen",
                "The title should match"
            )
            
            XCTAssertEqual(
                listings[2].price,
                3,
                "The price should be 3"
            )
            
        } else {
            XCTFail("The State should be loaded")
        }
    }
}
