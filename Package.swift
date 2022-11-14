// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxBinding",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "RxBinding",
            targets: ["RxBinding"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/RxSwiftCommunity/NSObject-Rx.git", branch: "master"),
    ],
    targets: [
        .target(
            name: "RxBinding",
            dependencies: [
                "RxSwift",
                .product(name: "RxCocoa", package: "RxSwift"),
                "NSObject-Rx"
            ]),
        .testTarget(
            name: "RxBindingTests",
            dependencies: ["RxBinding"]),
    ]
)
