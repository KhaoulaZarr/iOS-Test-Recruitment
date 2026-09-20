//
//  ListingViewModelFailureTests.swift
//  TheGoodCornerTests
//
//  Created by Khawla Zarrami on 19/09/2026.
//

import XCTest
@testable import TheGoodCorner

@MainActor
final class ListingViewModelFailureTests: XCTestCase {
    private var listingServiceMock: ListingServiceProtocol!
    private var categoryServiceMock: CategoryServiceProtocol!
    private var vm: ListingViewModel!
    

    override func setUp() {
        listingServiceMock = ListingServiceFailureMock()
        categoryServiceMock = CategoryServiceSuccessMock()
        vm = ListingViewModel(listingService: listingServiceMock, categoryService: categoryServiceMock)
    }
    
    override func tearDown() {
        listingServiceMock = nil
        categoryServiceMock = nil
        vm = nil
    }
    
    // When the server returns an invalid response, do we receive the expected error message?
    func test_with_unsuccessfull_response_error_is_handled() async {
        XCTAssertEqual(vm.loadingState , .idle, "The initial state should be idle")
        defer {
            if  case .error(let errorMessage) = vm.loadingState {
                XCTAssertEqual(errorMessage, "The server returned an invalid response.")
            } else {
                XCTFail("The state should be error")
            }
        }
        await vm.loadListings()
    }
   
}
