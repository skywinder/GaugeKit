// swift-tools-version:5.1
import PackageDescription
let package = Package(
    name: "GaugeKit",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "GaugeKit",
            targets: ["GaugeKit"])
    ],
    targets: [
        .target(
            name: "GaugeKit",
            path: "GaugeKit/"
            )]
)