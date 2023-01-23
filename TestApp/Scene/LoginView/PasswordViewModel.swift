//
//  PasswordViewModel.swift
//  TestApp
//
//  Created by Jiwon Yoon on 2023/01/23.
//

import Foundation
import RxSwift

protocol PasswordViewModelInput {
    func checkPassword(passcodes: String)
}

protocol PasswordViewModelOutput {
    var checkResultPublishSubject: PublishSubject<Bool> { get }
}

protocol PasswordViewModelType {
    var inputs: PasswordViewModelInput { get }
    var outputs: PasswordViewModelOutput { get }
}

final class PasswordViewModel: PasswordViewModelType, PasswordViewModelInput, PasswordViewModelOutput {
    var inputs: PasswordViewModelInput { self }
    var outputs: PasswordViewModelOutput { self }

    var checkResultPublishSubject: PublishSubject<Bool> = .init()

    func checkPassword(passcodes: String) {
        if passcodes == "123456" {
            outputs.checkResultPublishSubject.onNext(true)
        } else {
            outputs.checkResultPublishSubject.onNext(false)
        }
    }
}
