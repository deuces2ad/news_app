//
//  InterfaceExtendedController.swift
//  Health Tracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import UIKit
import GoogleMaps


class InterfaceExtendedController : ExtendedController {
    
    var disableBack : Bool = false
    private var isViewDidAppear : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        Log.echo(key : "rotate", text : "viewDidLoad in InterfaceExtended -> \(self)")
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        initialization()
        showNavigationBar()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            if(self.isViewDidAppear){
                return
            }
            self.isViewDidAppear = true
            self.viewAppeared()
        }
        
    }
    
    @objc override func viewDidRelease(){
        super.viewDidRelease()
        
        Log.echo(key : "rotate", text : "viewDidRelease in InterfaceExtended-> \(self)")
        guard let rootView = self.view as? ExtendedRootView
            else{
                return
        }
        rootView.onRelease()
    }
    
    //singular execution of viewDidAppear
    func viewAppeared(){
        
         Log.echo(key : "rotate", text : "viewAppeared in InterfaceExtended-> \(self)")
    }
    
    private func initialization(){
        
        registerForTapGestureForKeyboardResign()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Log.echo(key : "rotate", text : "viewWillAppear in InterfaceExtended -> isViewDidAppear -> \(isViewDidAppear) -> \(self)")
        
        //:todo
        /*self.notificationBar?.count = SignedUserInfo.sharedInstance?.notificationCount ?? 0*/
    }
    
    func paintNavigationLogo(){
        
        //
        let image = UIImage(named: "login_screen_logo")
        let frame = CGRect(x: 0 , y: 0, width: 194, height: 41)
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
      
        imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 900), for: .horizontal)
        imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 900), for: .horizontal)
        
        self.navigationItem.titleView = imageView
    }
    
    func hideNavigationBar(){
       
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func showNavigationBar(){
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func paintNavigationTitle(text : String?){
    
        guard let title = text else {
            return
        }
        self.title = title
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        guard let font = UIFont(name: AppThemeConfig.boldFont, size:18)
            else{
                return
        }
        titleLabel.font = font
        titleLabel.textColor = UIColor.white
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.text = text
        tabBarController?.title = text
        self.navigationItem.titleView = titleLabel
    }
    
    
    @objc func toggle(){
        
        Log.echo(key: "yud", text: "Toogle is calling")
        
//        UserSocket.sharedInstance?.registerSocket()
//        RootControllerManager().getCurrentController()?.toggleAnimation()
    }
        
    func paintHideBackButton(){
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.backItem?.hidesBackButton = true
    }
    
    func paintBackButton(){
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 5, width: 25, height: 25))
        
//        if SignedUserInfo.sharedInstance?.role  == .user{
//            imageView.image = UIImage(named : "back_white")
//        }else{
//            imageView.image = UIImage(named : "back_black")
//        }
        imageView.image = UIImage(named : "back_white")
        
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
        button.contentVerticalAlignment = .bottom
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        containerView.addSubview(button)
        
        let barItem = UIBarButtonItem(customView: containerView)
        
        var items = self.navigationItem.leftBarButtonItems ?? [UIBarButtonItem]();
        items.append(barItem)
        self.navigationItem.leftBarButtonItems = items
    }
    
    func paintLogout(){
//        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
//        button.contentVerticalAlignment = .bottom
//        button.setImage(UIImage(systemName: "sidebar.squares.trailing"), for: .normal)
//        button.imageView?.image = UIImage(systemName: "sidebar.squares.trailing")
//        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
//        let barItem = UIBarButtonItem(customView: button)
//        var items = self.navigationItem.rightBarButtonItems ?? [UIBarButtonItem]();
        
        let containerView = UIView(frame: CGRect(x: 10, y: 0, width: 40, height: 40))
//        containerView.backgroundColor = .blue
        
        let imageView = UIImageView(frame: CGRect(x: 8, y: 7, width: 25, height: 25))
       
//        imageView.backgroundColor = .red
        
//        if SignedUserInfo.sharedInstance?.role  == .user{
//            imageView.image = UIImage(named : "back_white")
//        }else{
//            imageView.image = UIImage(named : "back_black")
//        }
        imageView.image = #imageLiteral(resourceName: "ic_menu").withTintColor(.white, renderingMode: .alwaysOriginal)
        
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        
        
       
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
        button.contentVerticalAlignment = .bottom
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        containerView.addSubview(button)
        
        let barItem = UIBarButtonItem(customView: containerView)
        var items = self.navigationItem.leftBarButtonItems ?? [UIBarButtonItem]();
        items.append(barItem)
        self.navigationItem.rightBarButtonItems = items
    }
    
    @objc private func showActionSheet(){
        
//        toggle()
        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)


        actionSheet.addAction(UIAlertAction.init(title: "Profile".localized(), style: UIAlertAction.Style.default, handler: { (action) in
            DispatchQueue.main.async {
                self.showProfileVC()
            }
            
        }))

        actionSheet.addAction(UIAlertAction.init(title: "About Us".localized(), style: UIAlertAction.Style.default, handler: { (action) in
            self.showAboutUs()
        }))
        
        if SignedUserInfo.sharedInstance?.role == .patient{
            actionSheet.addAction(UIAlertAction.init(title: "Change Language".localized(), style: UIAlertAction.Style.default, handler: { (action) in
                self.changeLanguage()
            }))
        }
        
//        actionSheet.addAction(UIAlertAction.init(title: "Chat Support".localized(), style:.default, handler: { (action) in
//            self.chatSupportTapped()
//        }))
       
        if SignedUserInfo.sharedInstance?.role == .doctor{
            actionSheet.addAction(UIAlertAction.init(title: "See Appointments", style: .default,handler: { (action) in
                self.showFutureAppointments()
            }))
        }
       

        actionSheet.addAction(UIAlertAction.init(title: "Logout".localized(), style: UIAlertAction.Style.destructive, handler: { (action) in
            self.signOutTapped()
        }))
        
        
        
        actionSheet.addAction(UIAlertAction.init(title: "Cancel".localized(), style: UIAlertAction.Style.cancel, handler: { (action) in
        }))
        
    
        //Present the controller
        actionSheet.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem

        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func signOutTapped(){
        RootControllerManager().signOut {
            
        }
    }
    
    func showFutureAppointments(){
        let vc = FutureAppointmentsController()
        
        self.navigationController?.pushViewController(vc, animated:true)
        
    }
    
    func chatSupportTapped(){
        let cuurentUser = Sender(senderId: "self", displayName: "Aditi")
        let otherUser = Sender(senderId: "other", displayName: "Dr. Anna Maria")
        
        let chatVC = DoctorChatController(user: cuurentUser, otherUser: otherUser)
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func getNearestPoints(array: [CLLocationCoordinate2D], currentLocation: CLLocationCoordinate2D) -> [CLLocationCoordinate2D]{
        let current = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        var dictArray = [[String: Any]]()
        for i in 0..<array.count{
            let loc = CLLocation(latitude: array[i].latitude, longitude: array[i].longitude)
            let distanceInMeters = current.distance(from: loc)
            let a:[String: Any] = ["distance": distanceInMeters, "coordinate": array[i]]
            dictArray.append(a)
        }
        
        dictArray = dictArray.sorted(by: {($0["distance"] as! CLLocationDistance) < ($1["distance"] as! CLLocationDistance)})
        var sortedArray = [CLLocationCoordinate2D]()
        for i in dictArray{
            sortedArray.append(i["coordinate"] as! CLLocationCoordinate2D)
        }
        return sortedArray
    }
    
    func styleGoogleMaps(for map:GMSMapView){
        do{
            if let styleUrl = Bundle.main.url(forResource: "map_style", withExtension: "json"){
                map.mapStyle = try GMSMapStyle(contentsOfFileURL: styleUrl)
            }else{
                Log.echo(key: "ERROR", text: "Issue dound!")
            }
        }
        catch{
            Log.echo(key: "ERROR", text: "Issue dound!")
        }
    }
    
    func showProfileVC(){
        let vc = EditProfileController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func changeLanguage(){
        let alert = UIAlertController(title: AppInfoConfig.appName, message: "Please choose the prefered Language".localized() ?? "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "English", style: UIAlertAction.Style.default, handler: { action in
            UserDefaults.standard.setValue("en", forKey: LanguageKey)
            RootControllerManager().updateRoot()
        }))
        alert.addAction(UIAlertAction(title: "Spanish", style: UIAlertAction.Style.default, handler: { action in
            UserDefaults.standard.setValue("es", forKey: LanguageKey)
            RootControllerManager().updateRoot()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAboutUs(){
        let vc = AboutUsController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func settingAction(){
        
    }
    
    @objc func logouytAction(){
        
    }

    @objc func backAction(){
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func emptyNavButtons(){
        
        self.navigationItem.leftBarButtonItems?.removeAll()
        self.navigationItem.rightBarButtonItems?.removeAll()
    }
}


extension InterfaceExtendedController:UIGestureRecognizerDelegate{
    
    fileprivate func registerForTapGestureForKeyboardResign(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        return true
//    }
    
    @objc func hideKeyboard(){
        
        self.view.endEditing(true)
    }
}


extension UIViewController : NVActivityIndicatorViewable{
    
    func showLoader(text : String = "Loading...".localized() ?? ""){
        
        let size = CGSize(width: 30, height: 30)
        self.startAnimating(size, message: text, type: .lineScale)
    }
    
    func updateLoaderMessage(text : String = "Loading...".localized() ?? ""){
        
        NVActivityIndicatorPresenter.sharedInstance.setMessage(text)
    }
    
    func stopLoader(){
        
        self.stopAnimating()
    }
    
    func getRootPresentingController()-> UIViewController?{
        
        var presenting : UIViewController? = self.presentingViewController
        
        while(true){
            
            if let root = presenting?.presentingViewController{
                presenting = root
            }
            else{
                return presenting
            }
        }
    }

    
    func getTopMostPresentedController()-> UIViewController?{
        
        //If no controller is presented then it will return itself.
        if self.presentedViewController == nil {
            return self
        }
        var presented : UIViewController? = self.presentedViewController
        while(true){
            if let root = presented?.presentedViewController{
                presented = root
            }
            else{
                return presented
            }
        }
    }
    
    func boundGoogleMapWith(with source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, handler : (_ bounds : GMSCoordinateBounds) -> Void){
        //zoom the map to show the desired area
        var bounds = GMSCoordinateBounds()
        bounds = bounds.includingCoordinate(source)
        bounds = bounds.includingCoordinate(destination)
        handler(bounds)
//        self.rootView.mapView.moveCamera(GMSCameraUpdate.fit(bounds))
    }
    
    func addMarker(with coordinates : CLLocationCoordinate2D){
        let marker = GMSMarker(position: coordinates)
        marker.isDraggable = true
//        marker.map = rootView.mapView
        let camera = GMSCameraPosition(latitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 12)
//        rootView.mapView.animate(to: camera)
    }
    
    func setMapViewCamera( location : CLLocationCoordinate2D?, onMap mapView : GMSMapView?, with zoom : Float){
        guard let location = location else{
            Log.echo(key: "ERROR~!!", text: "No Location found to move camera to MAP!")
            return
        }
        let camera = GMSCameraPosition(latitude: location.latitude, longitude: location.longitude,zoom: zoom)
        CATransaction.begin()
        CATransaction.setValue(1.5, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: camera)
        CATransaction.commit()
    }
    
    func boundMapView(with start : CLLocationCoordinate2D, end : CLLocationCoordinate2D, on mapView : GMSMapView?){
        CATransaction.begin()
        CATransaction.setValue(1.5, forKey: kCATransactionAnimationDuration)
        let bounds = GMSCoordinateBounds(coordinate: start, coordinate: end)
        let update = GMSCameraUpdate.fit(bounds,withPadding: 120)
        mapView?.moveCamera(update)
        CATransaction.commit()
    }
    
    
    func showToastMessage(with message :String){
        DispatchQueue.main.async {
            
        
            let toastLbl = UILabel(frame: CGRect(x: self.view.frame.width/2 - 75, y: self.view.frame.height - 100, width: 150, height: 40))
            toastLbl.text = ""
            toastLbl.textAlignment = .center
            toastLbl.backgroundColor = .red.withAlphaComponent(0.6)
            toastLbl.textColor = .white
            toastLbl.alpha = 1.0
            toastLbl.layer.cornerRadius = 10
            toastLbl.clipsToBounds = true
            toastLbl.adjustsFontSizeToFitWidth = true
            toastLbl.numberOfLines = 0
            toastLbl.text = message
            self.view.addSubview(toastLbl)
            UIView.animate(withDuration: 4.0, delay: 0, options: .curveEaseInOut) {
                toastLbl.alpha = 0.0
                96
            } completion: { isCompleted in
                if isCompleted{
                    toastLbl.removeFromSuperview()
                }
            }
            
        }
    }
}

