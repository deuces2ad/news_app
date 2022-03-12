//
//  DetailedRoutesController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 26/08/21.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps

class DetailedRoutesController: InterfaceExtendedController {

    
    var locations = [CLLocationCoordinate2D]()
    var liveLocation : CLLocationCoordinate2D?
    var isTollAvoided = false
    var appointmentArr = [Appointmensts]()
    var delegate : AppointmentsSortingDelegate?
    let TAG = "DetailedRoutesController"
    
   //MARK:-LifeCylce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialization()
    }
    
    override func loadView() {
        super.loadView()
        self.view = rootView
        styleGoogleMaps(for: rootView.mapView)
    }
    
    //MARK:-Initialization
    func intialization(){
        paintInterface()
        registerTblViewCell()
        getLiveLocation()
        registerListener()
        addLonGesture()
    }
    
    func paintInterface(){
        paintBackButton()
        paintNavigationTitle(text: "Today's Route")
    }

    
    func addLonGesture(){
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(gestureRecognizer:)))
        rootView.appointmentsTblView.addGestureRecognizer(longpress)
    }
    
    
    @objc func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
      let longPress = gestureRecognizer as! UILongPressGestureRecognizer
      let state = longPress.state
      let locationInView = longPress.location(in: rootView.appointmentsTblView)
      let indexPath = rootView.appointmentsTblView.indexPathForRow(at: locationInView)
      
      struct My {
        static var cellSnapshot : UIView? = nil
        static var cellIsAnimating : Bool = false
        static var cellNeedToShow : Bool = false
      }
      struct Path {
        static var initialIndexPath : IndexPath? = nil
      }
      
      switch state {
      case UIGestureRecognizer.State.began:
          if indexPath != nil {
            Path.initialIndexPath = indexPath!
            let cell = rootView.appointmentsTblView.cellForRow(at: indexPath!)!
            My.cellSnapshot  = snapshotOfCell(inputView: cell)
            
            var center = cell.center
            My.cellSnapshot!.center = center
            My.cellSnapshot!.alpha = 0.0
              rootView.appointmentsTblView.addSubview(My.cellSnapshot!)
            
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
              center.y = locationInView.y
              My.cellIsAnimating = true
              My.cellSnapshot!.center = center
              My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
              My.cellSnapshot!.alpha = 0.98
              cell.alpha = 0.0
            }, completion: { (finished) -> Void in
              if finished {
                My.cellIsAnimating = false
                if My.cellNeedToShow {
                  My.cellNeedToShow = false
                  UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    cell.alpha = 1
                  })
                } else {
                  cell.isHidden = true
                }
              }
            })
        }
        
      case UIGestureRecognizer.State.changed:
          if My.cellSnapshot != nil {
            var center = My.cellSnapshot!.center
            center.y = locationInView.y
            My.cellSnapshot!.center = center
            
            if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                appointmentArr.insert(appointmentArr.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                let element = locations.remove(at: Path.initialIndexPath!.row)
                locations.insert(element, at: indexPath!.row)
                Log.echo(key: "yamii", text: "\(locations)")
                rootView.appointmentsTblView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
              Path.initialIndexPath = indexPath
                
            }
        }
        default:
          if Path.initialIndexPath != nil {
              guard let cell = rootView.appointmentsTblView.cellForRow(at: Path.initialIndexPath!) else{
                  return
              }
            if My.cellIsAnimating {
              My.cellNeedToShow = true
            } else {
              cell.isHidden = false
              cell.alpha = 0.0
            }
            
            UIView.animate(withDuration: 0.25, animations: { () -> Void in
              My.cellSnapshot!.center = cell.center
              My.cellSnapshot!.transform = CGAffineTransform.identity
              My.cellSnapshot!.alpha = 0.0
              cell.alpha = 1.0
              
            }, completion: { [weak self] (finished) -> Void in
              if finished {
                  
                Path.initialIndexPath = nil
                My.cellSnapshot!.removeFromSuperview()
                My.cellSnapshot = nil
                  self?.rootView.mapView.clear()
                  self?.getDetailedRoutes(with: self?.locations)
                  self?.delegate?.didEndSorting(info: self!.appointmentArr)
              }
            })
        }
      }
    }
    
    func snapshotOfCell(inputView: UIView) -> UIView {
      UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
      inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
      let image = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
      
      let cellSnapshot : UIView = UIImageView(image: image)
      cellSnapshot.layer.masksToBounds = false
      cellSnapshot.layer.cornerRadius = 0.0
      cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
      cellSnapshot.layer.shadowRadius = 5.0
      cellSnapshot.layer.shadowOpacity = 0.4
      return cellSnapshot
    }
    
    init(locations : [CLLocationCoordinate2D]) {
        super.init(nibName: nil, bundle: nil)
        self.locations = locations
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Set rootView
    lazy var rootView  : DetailedRoutesRootView = {
        let rootview = DetailedRoutesRootView()
        return rootview
    }()

    func getLiveLocation(){
        if let currentLocation = LocationManager.shared.currentLocation?.location.coordinate {
            self.liveLocation = currentLocation
        }
    }
    
    func registerListener(){
        rootView.didListenAvoidTolls = { [weak self] isAvoidtolls in
            guard let weakSelf = self else{return}
            DispatchQueue.main.async {
                weakSelf.isTollAvoided = isAvoidtolls
                weakSelf.rootView.mapView.clear()
                weakSelf.getDetailedRoutes(with: weakSelf.locations)
            }
        }
    }
    
    func registerTblViewCell(){
        Log.echo(key: "New ArrList", text: "\(appointmentArr)")
        rootView.appointmentsTblView.delegate = self
        rootView.appointmentsTblView.dataSource = self
        rootView.appointmentsTblView.register(AppointmentsCell.self, forCellReuseIdentifier: "AppointmentsCell")
    }
   
    
    func getDetailedRoutes(with locationsArr : [CLLocationCoordinate2D]?){
        showLoader()
//        39.0409459,  -77.0241062
//        let dummyCuurentLoction = CLLocationCoordinate2D(latitude: 32.7266, longitude: 74.8570)
//        let currentloc = dummyCuurentLoction
        
        guard let currentloc = liveLocation else{
            Log.echo(key: "Abhi", text: "No live location found")
            return
        }
        
        guard  let locationsArr : [CLLocationCoordinate2D] = locationsArr else{
            return
        }

//        let locationsArr = [CLLocationCoordinate2D(latitude: 31.3260, longitude: 75.5762),
//                            CLLocationCoordinate2D(latitude: 32.2733, longitude: 75.6522),
//                            CLLocationCoordinate2D(latitude: 30.7333, longitude: 76.7794)]
        
        
        Log.echo(key: "LocArr", text: "\(locationsArr)")
        
        
        for (index,loc) in locationsArr.enumerated(){
            let marker = GMSMarker()
            let markerView = CustomMarkerView(frame: .init(x: 0, y: 0, width: 60, height: 60), imageName:#imageLiteral(resourceName: "ic_profile"), borderColor: .black, isWithDownArrow: true, isTagLblRequired: true)
            markerView.tagLbl.text = "\(index + 1)"
            marker.iconView = markerView
            Log.echo(key: "Abhiii", text: "called out\(index)")
            marker.position = loc
            marker.zIndex = Int32(index)
            marker.map = rootView.mapView
        }
        let doctorMarer = GMSMarker()
        doctorMarer.iconView = rootView.doctorMarker
        doctorMarer.position = currentloc
        doctorMarer.map = rootView.mapView
        
        WayPointsService().drawPathFrom(for: locationsArr, avoidTolls: isTollAvoided) { [weak self] path, polyline in
            guard let self = self else {return}
            self.stopLoader()
            polyline?.map = nil
            polyline?.map = self.rootView.mapView
            let bounds = GMSCoordinateBounds(path: path!)
            let update = GMSCameraUpdate.fit(bounds,withPadding: 60)
            CATransaction.begin()
            CATransaction.setValue(3, forKey: kCATransactionAnimationDuration)
            self.rootView.mapView.moveCamera(update)
            CATransaction.commit()
        }
    }
}


extension DetailedRoutesController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentsCell", for: indexPath) as? AppointmentsCell else {
            return UITableViewCell()
        }
        cell.fillInfo(with: appointmentArr[indexPath.row])
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 550.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 110
    }
}


extension DetailedRoutesController : AppointmentsCellDelegate{
    func didTapOnCell(with info: DetailAppointmentInfo) {
        Log.echo(key: TAG, text: "Appointment Id and Week Id : \(info)")

        if  SignedUserInfo.sharedInstance?.role == .doctor {
            let vc = DoctorAppointmentDetailController(with: info)
            vc.appointment_id = info.apointment_id
            vc.rootView.getToPatientBtn.btn.isEnabled = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

