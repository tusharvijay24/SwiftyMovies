//
//  NetworkManager.swift
//  MovieList
//
//  Created by apple on 12/02/24.
//

import Foundation
import Reachability

class NetworkManager {
    static let shared = NetworkManager()
    private var reachability: Reachability?

    private init() {
        setupReachability()
    }

    private func setupReachability() {
        reachability = try? Reachability()
        
        reachability?.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("The network is reachable over the WiFi connection")
            } else if reachability.connection == .cellular {
                print("The network is reachable over the cellular connection")
            }
        }
        
        reachability?.whenUnreachable = { _ in
            print("The network is not reachable")
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start network reachability notifier")
        }
    }
    
    var isReachable: Bool {
        return reachability?.connection != .unavailable
    }
    
    var isReachableOnCellular: Bool {
        return reachability?.connection == .cellular
    }
    
    var isReachableOnWiFi: Bool {
        return reachability?.connection == .wifi
    }

    deinit {
        reachability?.stopNotifier()
    }
}
