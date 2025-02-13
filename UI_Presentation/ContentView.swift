import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var searchHandler = SearchHandler()
    
    var body: some View {
        ZStack {
            MapView(mapView: $searchHandler.mapView, region: $searchHandler.region)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .padding()
            
            if searchHandler.isSearchActive {
                SearchOverlay(searchHandler: searchHandler)
                    .transition(.move(edge: .top))
                    .zIndex(1)
            }
        }
        .ornament(
            visibility: .visible,
            attachmentAnchor: .scene(.bottomTrailing),
            contentAlignment: .trailing
        ) {
            HStack {
                Button("", systemImage: "plus.magnifyingglass") {
                    zoom(zoomIn: true)
                }
                
                Button("", systemImage: "minus.magnifyingglass") {
                    zoom(zoomIn: false)
                }
            }
            .labelStyle(.iconOnly)
            .padding(7)
            .glassBackgroundEffect()
        }
        
        .ornament(
            visibility: .visible,
            attachmentAnchor: .scene(.bottom),
            contentAlignment: .center
        ) {
            HStack {
                Button("Immersive View", systemImage: "mappin.and.ellipse") {
                    // Action for Immersive View
                }
                Button("3D View", systemImage: "map.circle.fill") {
                    // Action for 3D View
                }
            }
            .padding(7)
            .glassBackgroundEffect()
        }
        .ornament(
            visibility: .visible,
            attachmentAnchor: .scene(.bottomLeading),
            contentAlignment: .leading
        ) {
            HStack {
                Button("", systemImage: "magnifyingglass") {
                    withAnimation {
                        searchHandler.isSearchActive.toggle()
                    }
                }
                Button("", systemImage: "book.pages.fill") {
                }
            }
            .labelStyle(.iconOnly)
            .padding(7)
            .glassBackgroundEffect()
        }
    }
        
        private func zoom(zoomIn: Bool) {
            var newSpan = searchHandler.region.span
            let factor: Double = zoomIn ? 0.5 : 2.0
            
            newSpan.latitudeDelta *= factor
            newSpan.longitudeDelta *= factor
            
            // Limit zoom levels
            newSpan.latitudeDelta = max(0.001, min(newSpan.latitudeDelta, 180))
            newSpan.longitudeDelta = max(0.001, min(newSpan.longitudeDelta, 180))
            
            withAnimation(.easeInOut(duration: 0.3)) {
                searchHandler.region.span = newSpan
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



