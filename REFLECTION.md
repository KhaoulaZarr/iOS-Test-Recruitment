# Reflection— The Good Corner (technical test)
## AI Usage
I mainly used AI to:
* Review implementation approaches and suggest improvements.
* Help identify and organize expected static values used in UI test assertions, such as listing titles, prices, and category names.
* # Concrete AI Suggestion I Corrected
One concrete example was related to category filtering.
The application keeps the complete API response in allListings and uses loadingState for the listings currently displayed by the UI.
Initially, after fetching the data, `loadListings()` assigned:
```swift
allListings = feed.items

loadingState = allListings.isEmpty
    ? .empty
    : .loaded(allListings)
```
This worked initially, but created a problem when a category was selected and the user navigated to a listing detail and returned to the list. The current filter could be lost when the listings were loaded again.
I corrected this by reapplying the current category after updating the source data:
```swift
allListings = feed.items
filterByCategory(selectedCategoryID)
```
I also noticed that the `.task` attached to the listings screen could trigger another load when returning from the detail screen. To avoid an unnecessary network request and preserve the current list state, the initial load is now performed only while the ViewModel is in the `.idle` state:
```swift
.task {
    if viewModel.loadingState == .idle {
        await viewModel.loadListings()
    }
}
```
Explicit pull-to-refresh remains available through:
```swift
.refreshable {
    await viewModel.loadListings()
}
```
This also means that refreshing while a category is selected keeps the current filter because loadListings() reapplies selectedCategoryID.
## Architectural Decisions
I made the following architectural decisions during the implementation:
### ViewModel and State Management
I used a ListingViewModel to manage:
* Listing loading state.
* The complete list of listings.
* Categories and their IDs.
* The currently selected category.
* Category filtering.
* `allListings` is kept as the source of truth for the complete API response. The UI displays the filtered result through `loadingState`.
This allows filtering to be applied without modifying or losing the original API data.
### Service Abstraction
I defined protocols for the listing and category services:
<br>`ListingServiceProtocol`<br>
`CategoryServiceProtocol`<br>
The ViewModel receives these services through dependency injection.
This allows the production services to be replaced by mock services for UI and unit testing.
### Concurrent Requests
Listings and categories are independent network requests, so I fetch them concurrently using async let:
<br>`async let listingsTask = listingService.fetchListings()` <br>
`async let categoriesTask = categoryService.fetchCategories()`<br>
This avoids unnecessarily waiting for one request to finish before starting the other.
### UI State
The ViewModel represents the main UI states:
* .idle
* .loading
* .loaded
* .empty
* .error
  
The ViewModel updates this state based on the result of the data loading or filtering, while the view uses a `switch` to display the appropriate UI for each state.

This keeps the loading, empty, error, and content states in one place and makes the UI behavior easier to follow.
### Filtering
The category filter uses an optional category ID:
* nil means all categories.
* A category ID means that category is selected.
The filter screen uses a temporary selection so that cancelling the filter does not immediately modify the active filter.
### Accessibility
I added accessibility labels and identifiers to important interactive elements.
For listing cards, the image is treated as decorative and the card exposes a combined accessibility description containing the listing title, price, category, and urgent status.
### Testing
## Testing

I added unit, integration and UI tests covering the main networking, decoding, ViewModel, and UI scenarios.

### Unit Tests

- `JsonMapperTests` — verifies JSON decoding for listings and categories.
- `APIClientTests` — verifies API request behavior, successful responses, and HTTP/networking errors.
- `ListingViewModelSuccessTests` — verifies the ViewModel behavior when listings and categories are loaded successfully.
- `ListingViewModelFailureTests` — verifies the ViewModel behavior when a network request fails.

### UI Tests

- `ListingsScreenUITests` — verifies successful UI states, including the displayed listings, their titles, prices and categories.
- `ListingsFailureUITests` — verifies the listings screen failure state by simulating a networking failure and checking that the error message and `Retry` button are displayed.

The UI tests use mock networking controlled through launch arguments and environment values. This makes it possible to test success and failure states without depending on the real network.
### UI Decisions
The UI uses SwiftUI and follows a simple marketplace-oriented design.
The listing screen displays:
* Listing image.
* Title.
* Price.
* Category.
* Urgent indicator when applicable.
* A short description.

The description is limited to two lines in the listing card to keep the list compact. The complete information can be viewed on the detail screen.
I also introduced reusable application colors for the primary brand color and the light card background instead of repeating color definitions throughout the views.
The category filter is presented separately and allows the user to:
* Select a category.
* Select all categories.
* Cancel without applying changes.
* Reset the selection.
* Apply the selected filter.
## API Assumptions and Ambiguities

The main ambiguities I identified in the prompt and API were:

- The API provides `category_id` in each listing, while the category name is provided by a separate categories endpoint. I used the category endpoint to map category IDs to the names displayed in the UI.
- The requirements specify that the API listing order should be preserved. I therefore apply filtering without sorting the original `allListings` array.
- Listing images may be missing or unavailable. I handled this by displaying a placeholder while keeping the listing visible.
- No separate listing-detail endpoint was provided or required. The selected `Listing` is therefore passed directly to the detail view.
- The API provides `creation_date`, but no specific display format was required. I kept the value in the model and only transform it if formatting is needed for presentation.
- The price is represented as a numeric value matching the API response.
