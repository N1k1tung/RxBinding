//
//  RxBinding.swift
//  RxBinding
//
//  Created by Nikita Rodin on 14.11.22.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

public extension Reactive where Base: AnyObject {
    /// utilize result builder to allow using { } instead of ( ) and no need for ,
    /// - Parameter b: collection of build blocks
    func bind(@BindingsBuilder _ bindings: () -> [Disposable]) {
        bindings().forEach { $0.disposed(by: disposeBag) }
    }
    
}

// MARK: operator

/*
 example usage
 
 rx.bind {
    loginButton.rx.tap ~> vm.loginTapped
    emailButton.rx.tap ~> vm.emailTapped
 }
 rx.bind {
    table.rx.modelSelected ~> { [unowned self] in self.router.navigate(to: .someScreen($0) }
 }
 */

infix operator ~>

public func ~><O: ObservableConvertibleType, B: ObserverType>(_ lhs: O, _ rhs: B) -> Disposable where O.Element == B.Element {
    lhs.asObservable().observe(on: MainScheduler.instance)
        .bind(to: rhs.asObserver())
}

public func ~><T, O: ObservableConvertibleType>(_ lhs: O, _ rhs: @escaping (T) -> Void) -> Disposable where O.Element == T {
    lhs.asObservable().observe(on: MainScheduler.instance)
        .bind(to: AnyObserver {
            switch $0 {
            case .next(let element):
                rhs(element)
            default:
                break
            }
        })
}

@resultBuilder
public struct BindingsBuilder {
    public static func buildBlock(_ components: Disposable...) -> [Disposable] {
        components
    }
}
