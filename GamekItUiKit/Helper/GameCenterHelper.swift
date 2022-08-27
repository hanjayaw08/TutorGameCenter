//
//  GameCenterHelper.swift
//  GamekItUiKit
//
//  Created by Hanjaya Putra Wijangga on 24/08/22.
//

import Foundation
import GameKit

final class GameCenterHelper: NSObject {
    static let helper = GameCenterHelper()
    
    var viewController: UIViewController?
    
    override init() {
        super.init()
        
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            NotificationCenter.default
                .post(name: .authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)
            if GKLocalPlayer.local.isAuthenticated {
                GKLocalPlayer.local.register(self)
                print("Authenticated to Game Center!")
            } else if let vc = gcAuthVC {
                self.viewController?.present(vc, animated: true)
            }
            else {
                print("Error authentication to GameCenter: " +
                      "\(error?.localizedDescription ?? "none")")
            }
        }
    }
    
    func presentMatchmaker() {
        // 1
        guard GKLocalPlayer.local.isAuthenticated else {
            return
        }
        
        // 2
        let request = GKMatchRequest()
        
        request.minPlayers = 2
        request.maxPlayers = 2
        // 3
        request.inviteMessage = "Would you like to play Nine Knights?"
        
        // 4
        let vc = GKMatchmakerViewController(matchRequest: request)
        vc?.matchmakerDelegate = self
        vc?.matchmakingMode = GKMatchmakingMode.inviteOnly
        viewController?.present(vc!, animated: true)
        
    }
    
    static var isAuthenticated: Bool {
        return GKLocalPlayer.local.isAuthenticated
    }
}
extension Notification.Name {
    static let presentGame = Notification.Name(rawValue: "presentGame")
    static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}

extension GameCenterHelper: GKMatchmakerViewControllerDelegate{
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        print("ga jadi")
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true, completion: nil)
        print("error")
    }
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match : GKMatch){
//        viewController.dismiss(animated: true, completion: nil)
        print("berhasil")
        print("berhasil")
        print("berhasil")
        print("berhasil")
        print("berhasil")
    }
    
}

extension GameCenterHelper: GKLocalPlayerListener{
    func player(_ player: GKPlayer, didAccept invite : GKInvite){
                let viewController = GKMatchmakerViewController(invite: invite)
                   viewController?.matchmakerDelegate = self
                   let rootViewController = UIApplication.shared.windows.first!.rootViewController
                   rootViewController?.present(viewController!, animated: true, completion: nil)
        
    }
    func player(_ player: GKPlayer, didRequestMatchWithRecipients: [GKPlayer]){
    }
}

