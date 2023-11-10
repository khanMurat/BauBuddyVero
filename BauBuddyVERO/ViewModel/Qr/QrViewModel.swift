//
//  QrViewModel.swift
//  BauBuddyVERO
//
//  Created by Murat on 8.11.2023.
//

import UIKit
import AVFoundation
import RxSwift

class QRViewModel {

    var qrCodeResult = PublishSubject<String>()
    
    func processQRCode(content: String) {
        qrCodeResult.onNext(content)
    }
}
