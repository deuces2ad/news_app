//
//  UserSocket.swift
//  HealthTracker
//
//  Created by Grazitti on 23/09/21.
//

import Foundation
import PusherSwift

class UserSocket {
    
    fileprivate static var _sharedInstance : UserSocket?
    var pusher : Pusher?
    var pusherChannel : PusherChannel?
    var isRegisteredToServer = false
    let decoder = JSONDecoder()

    
     init() {
         initialization()
    }
    
    func initialization(){
        intializeVarible()
      
    }
    
    func intializeVarible(){
        // Instantiate Pusher
        pusher = Pusher(key: AppConnectionConfig.pusherKey, options: PusherClientOptions(host: .cluster(AppConnectionConfig.pusherCluster)))
        pusher?.delegate = self
        // Subscribe to a Pusher channel
         pusherChannel = pusher?.subscribe("Test-location-1")

    }
    
    func connectToPusher(){
        pusher?.connect()

    }
    
    static var  sharedInstance: UserSocket?{
        if (_sharedInstance != nil){
            return _sharedInstance
        }
        _sharedInstance = UserSocket()
        return _sharedInstance
    }
}

extension UserSocket :PusherDelegate{
    
    func changedConnectionState(from old: ConnectionState, to new: ConnectionState) {
        Log.echo(key: "pusher@50", text: old.rawValue)
        Log.echo(key: "pusher@51", text: new.stringValue())
        if new.stringValue() == "disconnected"{
            pusher?.connect()
        }
    }
    func failedToSubscribeToChannel(name: String, response: URLResponse?, data: String?, error: NSError?) {
        Log.echo(key: "pusher@53", text: name)
    }
    func debugLog(message: String) {
        Log.echo(key: "pusher@56", text: message)
    }
    
    func subscribedToChannel(name: String) {
        Log.echo(key: "pusher@61", text: name)
    }
    func failedToDecryptEvent(eventName: String, channelName: String, data: String?) {
        Log.echo(key: "pusher@73", text: "\(eventName) and \(data ?? "")")
    }
}
