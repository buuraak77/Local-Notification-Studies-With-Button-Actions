//
//  ViewController.swift
//  NotificationTry
//
//  Created by Burak Yılmaz on 30.08.2022.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var izinKontrol:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { granted, error in
            self.izinKontrol = granted
            
            if granted {
                print("Bildirimlere Izin verildi")
            }else {
                print("Bildirimlere Izın Verilmedi")
            }
        }
        
        
        
    }

    @IBAction func sendButtonClicked(_ sender: Any) {
        
        print("Bildirim Yola Çıktı Geliyo")
        
        if izinKontrol {
            
            let evet = UNNotificationAction(identifier: "yes", title: "Evet", options: .foreground)
            let hayır = UNNotificationAction(identifier: "no", title: "Hayır", options: .foreground)
            
            let kategori = UNNotificationCategory(identifier: "kat", actions: [evet,hayır], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([kategori])
            
            let içerik = UNMutableNotificationContent()
            içerik.title = "Title"
            içerik.subtitle = "AltBaşlık"
            içerik.body = "Mesaj"
            içerik.sound = UNNotificationSound.default
            içerik.categoryIdentifier = "kat"
            
            var date = DateComponents()
            date.minute = 40
            
            //Tekrarlı Ve Zaman Ayarlı Tetikleme
            //let tetikleme = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
            
            // Saniye Türünden tetikleme
            let tetikleme = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
            
            
            let bildirimIstegi = UNNotificationRequest(identifier: "Custom", content: içerik, trigger: tetikleme)
            
            
            UNUserNotificationCenter.current().add(bildirimIstegi)
            
            
            
            
        }
        
        
        
        
    }
    
}

extension ViewController:UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.sound,.badge,.banner])
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "yes" {
            print("Yes Tıklandı")
        }
        if response.actionIdentifier == "no" {
            print("No Tıklandı")
        }
        
        completionHandler()
    }
}

