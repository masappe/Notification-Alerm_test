//
//  ViewController.swift
//  Notification,Alerm_test
//
//  Created by Masato Hayakawa on 2019/05/13.
//  Copyright © 2019 masappe. All rights reserved.
//

import UIKit
import UserNotifications
import AVFoundation

class ViewController: UIViewController,UNUserNotificationCenterDelegate {

    @IBOutlet weak var triggerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var getLabel: UILabel!
    var audioPlayer: AVAudioPlayer!
    var testDate: [Int] = []
    var center: UNUserNotificationCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //delegateの設定
        center = UNUserNotificationCenter.current()
        center.delegate = self

        //時刻の更新
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (time) in
            let date = Date()
            let formmater = DateFormatter()
            formmater.dateFormat = "yyyy/MM/dd hh:mm:ss"
            self.timeLabel.text = formmater.string(from: date)
            })
        //イベントの発火
        timer.fire()
    }
    
    //notificationのデータの表示
    @IBAction func notificationInformationButton(_ sender: Any) {
        center.getPendingNotificationRequests(completionHandler: {(data) in
            for i in data {
                print(i.content)
            }
            
        })
        
    }
    //全てのnotificationを削除
    @IBAction func deleteNotification(_ sender: Any) {
        center.removeAllDeliveredNotifications()
    }
    
    //notificationを用い現在時刻に対して10秒後に通知が来るようにする
    @IBAction func pressButton(_ sender: Any) {
        getLabel.text = "Label"
        let afterTenSecond = Notification()
        afterTenSecond.setNotification(minute: 0, second: 10)
        let afterFiveMinute = Notification()
        afterFiveMinute.setNotification(minute: 5, second: 0)
        let afterTenMinute = Notification()
        afterTenMinute.setNotification(minute: 10, second: 0)
        
    }
    //delegateを設定することで使用可
    //通知前に呼ばれる
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //フォアグラウンドで欲しい機能を決める
        completionHandler([.alert,.sound,.badge])

        getLabel.text = "hello"
        
    }
    //delegateを設定することで使用可
    //通知後に呼ばれる
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        getLabel.text = "now got"
        center.removePendingNotificationRequests(withIdentifiers: ["fiveMinute","tenMinute"])
    }
    
    //現在の日付の取得
    func getDateInformation() -> [Int] {
        let date = Date()
        var nowDate: [Int] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        nowDate.append(Int(formatter.string(from: date))!)
        formatter.dateFormat = "MM"
        nowDate.append(Int(formatter.string(from: date))!)
        formatter.dateFormat = "dd"
        nowDate.append(Int(formatter.string(from: date))!)
        formatter.dateFormat = "hh"
        nowDate.append(Int(formatter.string(from: date))!)
        formatter.dateFormat = "mm"
        nowDate.append(Int(formatter.string(from: date))!)
        formatter.dateFormat = "ss"
        nowDate.append(Int(formatter.string(from: date))!)
        //        print(nowDate)
        return nowDate

    }

}

