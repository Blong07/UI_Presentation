import SwiftUI
import MapKit

class SearchHandler: ObservableObject {
    @Published var mapView = MKMapView()
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @Published var isSearchActive = false
    @Published var searchText = ""

    func searchAddress() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(String(describing: error))")
                return
            }

            if let item = response.mapItems.first {
                let coordinate = item.placemark.coordinate
                let newRegion = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )

                DispatchQueue.main.async {
                    self.region = newRegion
                    self.mapView.setRegion(newRegion, animated: true)
                    self.mapView.removeAnnotations(self.mapView.annotations)

                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.placemark.title
                    self.mapView.addAnnotation(annotation)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }
}
