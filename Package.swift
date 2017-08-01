// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "MySQL",
  dependencies: [
    .package(url: "https://github.com/nicholasjackson/swift-libmysql", from: "0.1.0")
  ],
  targets: [
    .testTarget(name: "MySQLTests", dependencies: ["MySQL"]),
    .testTarget(name: "IntegrationTests", dependencies: ["MySQL"]),
    .target(name: "MySQL"),
  ]
)
