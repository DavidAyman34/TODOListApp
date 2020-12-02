//
//  NetworkMonitor.swift
//  TODOApp-MVC-Demo
//
//  Created by Divo Ayman on 12/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Network

@available(iOS 12.0, *)
class NetworkManagaer{
    private static let sharedInstance = NetworkManagaer()
    
    class func shared() -> NetworkManagaer{
        return NetworkManagaer.sharedInstance
    }
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected:Bool = false
    public private(set) var connctionType: ConnectionType?
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    private init(){
        monitor = NWPathMonitor()
    }
    public func startMoniting(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
        
    }
    public func stopMoniting(){
        monitor.cancel()
    }
    private func getConnectionType(_ path: NWPath){
        if path.usesInterfaceType(.wifi){
            connctionType = .wifi
        }
        else if  path.usesInterfaceType(.cellular){
            connctionType = .cellular
        }
        else if  path.usesInterfaceType(.wiredEthernet){
            connctionType = .ethernet
        }
        else {
            connctionType = .unknown
        }
    }
}
