import SwiftUI

struct SearchOverlay: View {
    @ObservedObject var searchHandler: SearchHandler

    var body: some View {
        VStack {
            HStack {
                TextField("Search for a place or address", text: $searchHandler.searchText)
                  //  .textFieldStyle(RoundedBorderTextFieldStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 30))

                    .padding()

                Button(action: {
                    searchHandler.searchAddress()
                    withAnimation {
                        searchHandler.isSearchActive = false
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding()
                }
            }
            .background(Color.white.opacity(0.8))
            .cornerRadius(8)
            .padding()

            Spacer()
        }
    }
}
