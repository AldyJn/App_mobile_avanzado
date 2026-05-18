//
//  MiMapaViewController.swift
//  Semana09_integracion — Actividad 02 (GLAB-S10)
//

import UIKit
import MapKit

class MiMapaViewController: UIViewController {
    private let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let lima = CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428)
        let region = MKCoordinateRegion(
            center: lima,
            latitudinalMeters: 20_000,
            longitudinalMeters: 20_000
        )
        mapView.setRegion(region, animated: false)
    }
}
