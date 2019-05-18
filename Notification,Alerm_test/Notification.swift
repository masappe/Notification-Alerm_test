//
//  Notification.swift
//  Notification,Alerm_test
//
//  Created by Masato Hayakawa on 2019/05/17.
//  Copyright © 2019 masappe. All rights reserved.
//

import Foundation
import UserNotifications

class Notification {
    
    //現在の時間からminute,second後の時間を引数にする
    func setNotification(minute: Int,second: Int) {
        var trigger: UNNotificationTrigger
        let content = UNMutableNotificationContent()
        //dateを入れる配列のようなもの
        var notificationTime = DateComponents()
        //minute,second後の時間を取得
        let date = self.getDateInformation(minute: minute, second: second)
        //トリガーの設定
        notificationTime.year = date[0]
        notificationTime.month = date[1]
        notificationTime.day = date[2]
        notificationTime.hour = date[3]
        notificationTime.minute = date[4]
        notificationTime.second = date[5]
        print(notificationTime)
        trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        //通知内容の設定
        content.title = "通知が来ました"
        content.body = "\(date[0])年\(date[1])月\(date[2])日\(date[3])時\(date[4])分\(date[5])秒"
        //音の設定
        //カスタムサウンドの設定
        //29秒までの音楽は流せるがそれ以上はデフォルトになる
        let sound = UNNotificationSound(named: UNNotificationSoundName("test.wav"))
        content.sound = sound
        //        content.sound = .default
        //identifierの設定
        let identifier = "\(date[0])年\(date[1])月\(date[2])日\(date[3])時\(date[4])分\(date[5])秒"
        //通知の設定
        //identifierは通知のキャンセルなどで使用する
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        //通知のセット
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
    

    //設定された時間後の値を取得
    private func getDateInformation(minute: Int,second:Int) -> [Int] {
        let date = Date()
        var nowDate: [Int] = []
        let formatter = DateFormatter()
        var dateComponents = DateComponents()
        dateComponents.minute = minute
        dateComponents.second = second
        let selectedDate = Calendar.current.date(byAdding: dateComponents, to: date)
        formatter.dateFormat = "YYYY"
        nowDate.append(Int(formatter.string(from: selectedDate!))!)
        formatter.dateFormat = "MM"
        nowDate.append(Int(formatter.string(from: selectedDate!))!)
        formatter.dateFormat = "dd"
        nowDate.append(Int(formatter.string(from: selectedDate!))!)
        formatter.dateFormat = "hh"
        nowDate.append(Int(formatter.string(from: selectedDate!))!)
        formatter.dateFormat = "mm"
        nowDate.append(Int(formatter.string(from: selectedDate!))!)
        formatter.dateFormat = "ss"
        nowDate.append(Int(formatter.string(from: selectedDate!))!)
        //        print(nowDate)
        return nowDate
        
    }

    
}
