//
//  NearbyATM.swift
//  IbankApp
//
//  IbankApp
//
//  Created by Naveen Bajaj and Rashiv Romio on 5/04/2016.
//  Copyright © 2016 Rmit. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class NearbyATM: UIViewController, CLLocationManagerDelegate {
    
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var branchDetails: [String] = ["Melbourne Central, Gd63/211 La Trobe St, Melbourne VIC 3000","367 Collins St, Melbourne VIC 3000","176 Lonsdale St, Melbourne VIC 3000","51-53 Errol St, North Melbourne VIC 3051","Melbourne Central, Gd63/211 La Trobe St, Melbourne VIC 3000","277 Clarendon Rd, South Melbourne VIC 3205","380 St Kilda Rd, Melbourne VIC 3004","7 Commercial Rd, Melbourne VIC 3004","55 Victoria Parade, Fitzroy VIC 3065"];
   
        override func viewDidLoad() {
        
        super.viewDidLoad()
        //for side bar menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
//            let geoCoder = CLGeocoder()
//            var coords: CLLocationCoordinate2D?
//            let span = MKCoordinateSpanMake(0.01, 0.01)
//            
//            geoCoder.geocodeAddressString(branchDetails[0], completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
//                
//                if let placemark = placemarks?[0] {
//                    
//                    // Convert the address to a coordinate
//                    let location = placemark.location
//                    coords = location!.coordinate
//                    
//                    // Set the map to the coordinate
//                    let region = MKCoordinateRegion(center: coords!, span: span)
//                    self.mapView.region = region
//                    
//                    // Add a pin to the address location
//                    self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
//                    //self.mapView.addAnnotations(<#T##annotations: [MKAnnotation]##[MKAnnotation]#>)
//                    
//                                   }
//                
//            })
            
            let annotations = getMapAnnotations()
            // Add mappoints to Map
            mapView.addAnnotations(annotations)
            zoomToRegion()

    }
 
    func zoomToRegion() {
        
        let location = CLLocationCoordinate2D(latitude: -37.81683, longitude: 144.96716)
        
        let region = MKCoordinateRegionMakeWithDistance(location, 5000.0, 7000.0)
        
        mapView.setRegion(region, animated: true)
    }
    
    func getMapAnnotations() -> [Branch]{
    var annotations:Array = [Branch]()
    
    //load plist file
    var branches: NSArray?
    if let path = NSBundle.mainBundle().pathForResource("branches", ofType: "plist") {
    branches = NSArray(contentsOfFile: path)
    }
    
    //iterate and create annotations
    if let items = branches {
    for item in items {
    let lat = item.valueForKey("lat") as! Double
    let long = item.valueForKey("long")as! Double
    let annotation = Branch(latitude: lat, longitude: long)
    annotation.title = item.valueForKey("title") as? String
    annotations.append(annotation)
    }
    }
    
    return annotations
    }
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if !(annotation is MKPointAnnotation) {
            print("bsdhfgsdgfhjfdjlkaj")
            return nil
        }
        print("qwe3444")
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.image = UIImage(named:"AppIcon-2")
            anView!.canShowCallout = true
        }
        else {
            anView!.annotation = annotation
        }
        
        return anView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
