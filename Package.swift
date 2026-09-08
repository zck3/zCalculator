// swift-tools-version: 6.2
//=============================================================================
// This file is part of zCalculator, which is my SwiftQt-based calculator.
// (C) 2026 Zack T Smith.
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
//
// The author may be reached at 3 at zs3 dot me.
//=============================================================================

import PackageDescription

let package = Package(
    name: "zCalculator",
    dependencies: [
        .package(url: "https://github.com/zck3/SwiftQt", branch: "main"),
        //.package(url: "file:///home/zack/Projects/SwiftQt", branch: "main"),
	.package(url: "https://github.com/nicklockwood/Expression.git", .upToNextMinor(from: "0.13.0")),
    ],
    targets: [
        .executableTarget(
            name: "zCalculator",
            dependencies: [
                .product(name: "SwiftQt", package: "SwiftQt"),
                .product(name: "Expression", package: "Expression"),
            ],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        )
    ]
)
