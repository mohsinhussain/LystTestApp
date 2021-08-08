//
//  InternetObserver.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import Foundation
import Reachability

public class InternetObserver {
    
    private var reachability = try? Reachability()

    // MARK: - Singleton -
    static public let shared = InternetObserver()

    public var isNetworkReachable = false

    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged, object: reachability)
    }

    // MARK: - Public -

    public func startNetworkListener() {
        DispatchQueue.main.async {
            if self.reachability == nil {
                self.reachability = try? Reachability()
            }
            try? self.reachability?.startNotifier()
            if let reachability = self.reachability {
                self.updateReachability(reachability: reachability)
            }
        }
    }

    public var isOnline: Bool {
        guard let reachability = reachability else { return false }
        return reachability.connection != .unavailable
    }

    public func stopNotifier() {
        reachability?.stopNotifier()
    }

    // MARK: - Private -

    @objc func reachabilityChanged(note: Notification) {
        if let reachability = note.object as? Reachability {
            updateReachability(reachability: reachability)
        }
    }

    private func updateReachability(reachability: Reachability) {
        let previousNetworkStatus = isNetworkReachable
        switch reachability.connection {
        case .wifi:
            isNetworkReachable = true
            print("Reachable via WiFi")
        case .cellular:
            isNetworkReachable = true
            print("Reachable via Cellular")
        case .unavailable:
            isNetworkReachable = false
            print("Network not reachable")
        case .none:
            isNetworkReachable = false
            print("Network not reachable")
        }
        if previousNetworkStatus != isNetworkReachable {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNames.rechabilityStatusChanged),
                                            object: isNetworkReachable)
        }
    }
}
