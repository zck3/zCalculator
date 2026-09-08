/*=========================================================================
 * This is zCalculator using SwiftQt.
 * (C) 2026 Zack T Smith.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 * The author may be reached at 3 at zs3 dot me.
 *=======================================================================*/

import Foundation
import SwiftQt

@main
@MainActor
struct AppStruct {
	static func main() -> Void 
	{
		print ("SwiftQt release \(SwiftQt.release), i.e. \(SwiftQt.major).\(SwiftQt.minor) ")

		let argc = CommandLine.arguments.count
		let argv = CommandLine.arguments
		print ("argc \(argc) argv \(argv)")
		application = QApplication(argc: argc, argv: argv);

		let app = App()
		QApplication.exec()
		app.teardown()
	}
}

@MainActor
class App {
	var calculatorWindow : CalculatorWindow?

	public static let release = "0.4"

	let maximumWidth = 300
	let maximumHeight = 400

	required init () {
		let dpi = QScreen.primaryScreenLogicalDotsPerInch()
		let width = QScreen.primaryScreenWidth()
		let height = QScreen.primaryScreenHeight()
		print ("Primary screen DPI=\(dpi), size=\(width)x\(height)")

		calculatorWindow = CalculatorWindow(x: 100, y: 100, width: maximumWidth, height: maximumHeight)
		calculatorWindow?.setMinimumSize(maximumWidth, maximumHeight)
		calculatorWindow?.setMaximumSize(maximumWidth, maximumHeight)
		calculatorWindow?.show()
	}

	public func teardown() {
		self.calculatorWindow = nil
	}

	deinit {
	}
}
