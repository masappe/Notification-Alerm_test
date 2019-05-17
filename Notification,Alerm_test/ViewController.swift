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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
    //Timer機能と配列を用いた現在の時刻と設定した時刻が一致しているかの確認
    //時間の設定
    @IBAction func nextButton(_ sender: Any) {
        testDate = getDateInformation()
        testDate[5] = testDate[5] + 10
        let chooseTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkDate), userInfo: nil, repeats: true)
    }
    //現在の日付と設定した日付が一致しているかどうか
    @objc func checkDate() {
        let currentDate = getDateInformation()
        getLabel.text = "testDate:\(testDate)\ncheckDate:\(currentDate)"
        if testDate == currentDate {
            let soundFilePath = Bundle.main.path(forResource: "BGM_battle001", ofType: "mp3")
            let sound = URL(fileURLWithPath: soundFilePath!)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: sound)
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                try AVAudioSession.sharedInstance().setActive(true, options: [])
                getLabel.text = "music start"
            } catch {
                print("error")
            }
            audioPlayer.play()

        }
    }

    //notificationを用い現在時刻に対して10秒後に通知が来るようにする
    @IBAction func pressButton(_ sender: Any) {
        getLabel.text = "Label"
        let afterTenSecond = Notification()
        afterTenSecond.setNotification(minute: 0, second: 10, identifier: "tenSecond")
        let afterFiveMinute = Notification()
        afterFiveMinute.setNotification(minute: 5, second: 0, identifier: "fiveMinute")
        let afterTenMinute = Notification()
        afterTenMinute.setNotification(minute: 10, second: 0, identifier: "tenMinute")
//        //delegateの設定
//        let center = UNUserNotificationCenter.current()
//        center.delegate = self
//
//        var trigger: UNNotificationTrigger
//        let content = UNMutableNotificationContent()
//        //dateを入れる配列のようなもの
//        var notificationTime = DateComponents()
//        //現在の日付の取得
//        let date = getDateInformation()
//        //トリガーの設定
//        //10秒後に発火するようにする
//        notificationTime.year = date[0]
//        notificationTime.month = date[1]
//        notificationTime.day = date[2]
//        notificationTime.hour = date[3]
//        notificationTime.minute = date[4]
//        notificationTime.second = date[5] + 10
//        print(notificationTime)
//        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
//        //通知内容の設定
//        content.title = "通知が来ました"
//        content.body = "音が出るのかの確認"
//        //音の設定
//        //カスタムサウンドの設定
//        //29秒までの音楽は流せるがそれ以上はデフォルトになる
//        let sound = UNNotificationSound(named: UNNotificationSoundName("test.wav"))
//        content.sound = sound
////        content.sound = .default
//        //通知の設定
//        //identifierは通知のキャンセルなどで使用する
//        let request = UNNotificationRequest(identifier: "time", content: content, trigger: trigger)
//        //通知のセット
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//
        //labelに設定
//        triggerLabel.text = "\(date[0])年\(date[1])月\(date[2])日\(date[3])時\(date[4])分\(date[5]+10)秒"
        
    }
    
    //通知前に呼ばれる
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //フォアグラウンドで欲しい機能を決める
        completionHandler([.alert,.sound,.badge])
        var audioPlayer: AVAudioPlayer!

        getLabel.text = "hello"
        
    }
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

