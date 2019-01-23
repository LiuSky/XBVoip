//
//  XBVoipManager.swift
//  XBVoip
//
//  Created by xiaobin liu on 2019/1/23.
//  Copyright © 2019 Sky. All rights reserved.
//

import UIKit
import PushKit
import Foundation
import UserNotifications


/// MARK - 网络电话管理类
public class XBVoipManager: NSObject {

    /// 获取单利XBVoipManager
    public static let standard = XBVoipManager()
    
    /// SpeechSynthesizer
    private lazy var speechSynthesizer: MKSpeechSynthesizer = {
        let speechSynthesizer = MKSpeechSynthesizer()
        return speechSynthesizer
    }()
    
    /// 初始化
    public override init() {}
   
    
    /// 初始化Voip
    public func registerVoip() {
        
        let pushRegistry = PKPushRegistry(queue: DispatchQueue.main)
        pushRegistry.delegate = self
        pushRegistry.desiredPushTypes = [.voIP]
        self.registerAPNS()
    }
    
    
    /// 注册APNS
    private func registerAPNS() {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        let types = UNAuthorizationOptions([.alert,.badge,.sound])
        notificationCenter.requestAuthorization(options: types, completionHandler: { (flag, error) in
            if flag {
                debugPrint("注册成功")
            } else {
                debugPrint("注册失败:\(error.debugDescription)")
            }
        })
        UIApplication.shared.registerForRemoteNotifications()
    }
}



// MARK: - PKPushRegistryDelegate
extension XBVoipManager: PKPushRegistryDelegate {
    
    
    /// 当接收到指定的凭证(包括push令牌)时，将调用此方法
    ///
    /// - Parameters:
    ///   - registry: <#registry description#>
    ///   - pushCredentials: <#pushCredentials description#>
    ///   - type: <#type description#>
    public func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        
        guard pushCredentials.token.count > 0 else {
            return
        }
        
        //应用启动获取token，并上传服务器
        debugPrint(pushCredentials.token.hexString)
    }
    
    /// 当收到指定PKPushType的推送通知时，将调用此方法
    ///
    /// - Parameters:
    ///   - registry: <#registry description#>
    ///   - payload: <#payload description#>
    ///   - type: <#type description#>
    ///   - completion: <#completion description#>
    public func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        
        var isCalling = false
        switch UIApplication.shared.applicationState {
        case .active:
            isCalling = false
        case .inactive:
            isCalling = false
        case .background:
            isCalling = true
        default:
            isCalling = true
        }
        
        // 开始打电话了
        if isCalling {
            self.callNotification()
        }
    }
    
    
    
    /// 通知内容
    private func callNotification() {
        
        speechSynthesizer.play("您有一笔新的收款50000元") { (com) in
            /// 通知中心
        }
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        /// 内容
        let content = UNMutableNotificationContent()
        content.title = "提示"
        content.body = "您有一笔新的订单50000"
        content.badge = NSNumber(value: content.badge?.intValue ?? 0 + 1)
        content.userInfo = [:]
        
        /// 设置时间
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "1", content: content, trigger: trigger)
        center.add(request) { _ in }
    }
}



// MARK: - UNUserNotificationCenterDelegate
extension XBVoipManager: UNUserNotificationCenterDelegate {
    
    
    /// 后台点击通知的代理方法
    ///
    /// - Parameters:
    ///   - center: <#center description#>
    ///   - response: <#response description#>
    ///   - completionHandler: <#completionHandler description#>
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    
    /// 前台收到通知的代理方法
    ///
    /// - Parameters:
    ///   - center: <#center description#>
    ///   - notification: <#notification description#>
    ///   - completionHandler: <#completionHandler description#>
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        debugPrint(notification.request.content)
        completionHandler([.alert,.badge])
    }
}


