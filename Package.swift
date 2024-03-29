// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ux",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "Ux", targets: ["Ux"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: Version(6, 1, 0))),
        .package(url: "https://github.com/mitsuse/screen-container", .upToNextMajor(from: Version(0, 5, 0)))
    ],
    targets: [
        .target(
            name: "Ux",
            dependencies: [
                 .product(name: "RxCocoa", package: "RxSwift"),
                 .product(name: "RxSwift", package: "RxSwift"),
                 .product(name: "ScreenContainer", package: "screen-container"),
            ]
        ),
    ]
)
