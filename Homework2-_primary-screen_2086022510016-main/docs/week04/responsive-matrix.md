# Responsive Matrix — Primary Screen

| Screen | Test | Status | Fixes & Notes |
| :--- | :--- | :--- | :--- |

Large Phone Screen (430 dp): PASS. All the cards with products, search bar and banners with information were displayed correctly on the screen.



Tablet (800 dp): PASS. I did it thanks to the LayoutBuilder and the breakpoint of 600 dp. However, the interface has changed from the single one column layout to the two-column one. On the left there were filters and news while on the right there was a list of products.



Landscape orientation: PASS. I managed to fix it by wrapping all the widgets into the SingleChildScrollable or ListView.builder that allow to scroll the page vertically when rotating the device.



Long Text (200 Characters): PASS. All the text in the app (product titles, artist’s name, variations, dialogs) was displayed properly thanks to the maxLines attribute and TextOverflow.ellipsis.



Empty State: PASS. It is possible to see correctly empty state that appears when there are no products due to the search query or filters. However, there is an icon (search_off_rounded), information about the problem and a button to reset the filter.



Long List (500 items): PASS. I managed to display 500 items in the scrollable list. For that purpose, first, I used the getLargeMockProducts(count: 500) method and then I displayed them with the help of the ListView.builder without shrinkWrap: true, which would take much space.



Keyboard open: PASS. When the user opens a virtual keyboard by clicking on search field on the small screen, the text field is not closed while the rest of the app is scrolled down and stays fully visible.



Dark mode: PASS. The app was designed with Material 3 in mind which has the ColorScheme.fromSeed. As a result, it looks good both on light and dark modes and all the text is readable.