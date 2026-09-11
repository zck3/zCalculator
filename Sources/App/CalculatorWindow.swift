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

// This more or less a port of my Objective-C app Eval, which is 
// an expression-evaluating calculator, but without the graphing part 
// and without my own C-based expression evaluator.

import Foundation
import SwiftQt
import Expression

@MainActor
class CalculatorWindow : QMainWindow {
	
	private var expressionString = ""
	private var lastResult : Double = 0.0

	private var menuBar : QMenuBar?

	private var buttonAdd : QPushButton?
	private var buttonSub : QPushButton?
	private var buttonMul : QPushButton?
	private var buttonDiv : QPushButton?
	private var buttonPower : QPushButton?

	private var buttonE : QPushButton?
	private var buttonPi : QPushButton?

	private var buttonLeftParens : QPushButton?
	private var buttonRightParens : QPushButton?
	private var buttonInsertResult : QPushButton?
	private var buttonClear : QPushButton?

	private var buttonAbsolute : QPushButton?
	private var buttonSine : QPushButton?
	private var buttonCosine : QPushButton?
	private var buttonTangent : QPushButton?
	private var buttonArcsine : QPushButton?
	private var buttonArccosine : QPushButton?
	private var buttonArctangent : QPushButton?
	private var buttonLn : QPushButton?
	private var buttonLog10 : QPushButton?
	private var buttonSquareRoot : QPushButton?

	private var button1 : QPushButton?
	private var button2 : QPushButton?
	private var button3 : QPushButton?
	private var button4 : QPushButton?
	private var button5 : QPushButton?
	private var button6 : QPushButton?
	private var button7 : QPushButton?
	private var button8 : QPushButton?
	private var button9 : QPushButton?
	private var button0 : QPushButton?
	private var buttonDelete : QPushButton?
	private var buttonDot : QPushButton?
	private var buttonComma : QPushButton?

	private var buttonEnter : QPushButton?

	private var expressionField : QLineEdit?
	private var tapeTextView : QTextEdit?

	//----------------------------------------

	public required init (x: SQCoord, y: SQCoord, width: SQCoord, height: SQCoord) 
	{
		super.init (x: x, y: y, width: width, height: height)

		constructUI()

		self.windowResizedHandler = { [weak self] (_ event : SQEvent) -> Void in 
			self?.layoutUI ()
		}
		self.windowClosedHandler = { [weak self] in
			self?.tearDownUI()
		}
	}

	private func tearDownUI () 
	{
		setMenuBar (nil)

		buttonAdd?.setParent(nil)
		buttonSub?.setParent(nil)
		buttonMul?.setParent(nil)
		buttonDiv?.setParent(nil)
		buttonPower?.setParent(nil)

		buttonE?.setParent(nil)
		buttonPi?.setParent(nil)

		buttonLeftParens?.setParent(nil)
		buttonRightParens?.setParent(nil)
		buttonInsertResult?.setParent(nil)
		buttonClear?.setParent(nil)

		buttonAbsolute?.setParent(nil)
		buttonSine?.setParent(nil)
		buttonCosine?.setParent(nil)
		buttonTangent?.setParent(nil)
		buttonArcsine?.setParent(nil)
		buttonArccosine?.setParent(nil)
		buttonArctangent?.setParent(nil)
		buttonLn?.setParent(nil)
		buttonSquareRoot?.setParent(nil)

		button1?.setParent(nil)
		button2?.setParent(nil)
		button3?.setParent(nil)
		button4?.setParent(nil)
		button5?.setParent(nil)
		button6?.setParent(nil)
		button7?.setParent(nil)
		button8?.setParent(nil)
		button9?.setParent(nil)
		button0?.setParent(nil)
		buttonDelete?.setParent(nil)
		buttonDot?.setParent(nil)
		buttonComma?.setParent(nil)
		buttonLog10?.setParent(nil)

		buttonEnter?.setParent(nil)

		expressionField?.setParent(nil)
		tapeTextView?.setParent(nil)
	}

	/* Manually lays out the user interface.
	 * TODO: Switch to grid layout.
	 */
	private func layoutUI () {
		guard let menuBar = self.menuBar else {
			return
		}

		let menuBarHeight : Int = menuBar.height()

		let availableWidth : Int = windowWidth ()
		let availableHeight : Int = windowHeight ()
		print ("Swift: LAYING OUT UI, WINDOW IS \(availableWidth)x\(availableHeight)")

		let padding : Int = 8

		var y = menuBarHeight + padding
		
		let x = padding
		
		let expressionHeight = 30
		expressionField?.setFrame (QRect.new(padding, y, availableWidth-2*padding, expressionHeight))
		y += expressionHeight + padding
		
		let tapeHeight = 60
		tapeTextView?.setFrame (QRect.new(x, y, availableWidth-2*padding, tapeHeight))
		y += tapeHeight + padding
		
		let w = (availableWidth - 6*padding) / 5
		let h = abs((availableHeight-y-7*padding) / 7)
		let xs = w + padding
		let ys = h + padding
		
		var i = 0
		var j = 0

		buttonSine?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonCosine?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonTangent?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonPi?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonClear?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		
		i = 0
		j += 1
		
		buttonArcsine?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonArccosine?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonArctangent?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonSquareRoot?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonDelete?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		
		i = 0
		j += 1
		
		buttonLn?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonLog10?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonLeftParens?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonRightParens?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonDiv?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		
		i = 0
		j += 1
		
		//	button_a?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		//i += 1
		buttonE?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		button7?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		button8?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		button9?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonMul?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		
		i = 0
		j += 1
		
		//	button_b?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		//i += 1
		buttonPower?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		button4?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		button5?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		button6?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonSub?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		
		i = 0
		j += 1
		
		//	button_c?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		//i += 1
		buttonAbsolute?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		button1?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		button2?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		button3?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonAdd?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		
		i = 0
		j += 1
		
		buttonInsertResult?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		button0?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonDot?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonComma?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
		buttonEnter?.setFrame (QRect.new(x + i * xs, y + j * ys, w, h))
		i += 1
	}

	public func createMenus ()
	{
		let fileMenu : QMenu = QMenu("&File")
		let actionClose = fileMenu.addAction ("C&lose", { [weak self] in
			guard let self = self else {
				return
			}
			print ("FILE->CLOSE")
			self.close()
		})
		actionClose!.setShortcut (QKeySequence.Close())

		let actionQuit = fileMenu.addAction ("&Quit", {
			print ("FILE->EXIT")
			QApplication.quit()
		})
		actionQuit!.setShortcut (QKeySequence.Quit())

		_ = fileMenu.addAction ("&Clear Tape", { [weak self] in
			self?.tapeTextView?.setText("")
		})

		let helpMenu : QMenu = QMenu("&Help")
		_ = helpMenu.addAction ("&About", {
			print ("HELP->ABOUT")
			SwiftQt.infoPopup ("This is zCalculator \(App.release), an expression-evaluating calculator.\nBy Zack T Smith\n\nIt uses my SwiftQt framework for the GUI and\nNick Lockwood's Expression framework for the math.\n\nTo enter expressions, you can use the GUI buttons or your keyboard. (The equals key serves as Enter.)\n\nNote that angles are in radians.")
		})

		menuBar = QMenuBar ()
		menuBar!.addMenu (fileMenu)
		menuBar!.addMenu (helpMenu)
		setMenuBar (menuBar!)
	}

	private func createButton (_ text: String, _ closure: @escaping (() -> Void)) -> QPushButton
	{
		let button = QPushButton (self, text)
		button.clickedHandler = closure
		return button
	}

	private func constructUI () 
	{
		createMenus()
	
		tapeTextView = QTextEdit (self)
		tapeTextView?.setReadOnly (true) // We don't want keyboard focus to go to the tape.
		tapeTextView?.setText ("")
		
		let placeholder = "Expression"
		expressionField = QLineEdit (self)
		expressionField?.setPlaceholderText (placeholder)
		expressionField?.setAlignment (Qt.AlignRight)
		
		buttonE = createButton("e", userPressedE)
		buttonEnter = createButton("Enter", userPressedEnter)
		buttonClear = createButton("CLR", userPressedClear)
		buttonAbsolute = createButton("ABS", userPressedAbsolute)
		
		button0 = createButton("0", userPressed0)
		button1 = createButton("1", userPressed1)
		button2 = createButton("2", userPressed2)
		button3 = createButton("3", userPressed3)
		button4 = createButton("4", userPressed4)
		button5 = createButton("5", userPressed5)
		button6 = createButton("6", userPressed6)
		button7 = createButton("7", userPressed7)
		button8 = createButton("8", userPressed8)
		button9 = createButton("9", userPressed9)
		
		buttonInsertResult = createButton("INS", userPressedInsertResult)
		buttonPower = createButton("POW", userPressedRaiseToPower)
		buttonPi = createButton("π", userPressedPi)
		buttonSine = createButton("SIN", userPressedSine)
		buttonArccosine = createButton("ACOS", userPressedArccosine)
		buttonAdd = createButton("+", userPressedAdd)
		buttonArcsine = createButton("ASIN", userPressedArcsine)
		buttonArctangent = createButton("ATAN", userPressedArctangent)
		buttonCosine = createButton("COS", userPressedCosine)
		buttonDelete = createButton("Del", userPressedDelete)
		buttonDiv = createButton("/", userPressedDivide)
		buttonDot = createButton(".", userPressedDot)
		buttonLn = createButton("LN", userPressedNaturalLog)
		buttonLog10 = createButton("LOG", userPressedLog10)
		buttonMul = createButton("*", userPressedMultiply)
		buttonSquareRoot = createButton("SQRT", userPressedSquareRoot)
		buttonComma = createButton(",", userPressedComma)
		buttonSub = createButton("-", userPressedSubtract)
		buttonTangent = createButton("TAN", userPressedTangent)
		buttonLeftParens = createButton("(", userPressedLeftParens)
		buttonRightParens = createButton(")", userPressedRightParens)
		
		let formulaStyle = "background-color : black; color : yellow;"
		expressionField?.setStyleSheet(formulaStyle)

		let buttonStyle = "background-color : white; color : #080;"
		buttonAdd?.setStyleSheet (buttonStyle)
		buttonSub?.setStyleSheet (buttonStyle)
		buttonMul?.setStyleSheet (buttonStyle)
		buttonDiv?.setStyleSheet (buttonStyle)
		buttonPower?.setStyleSheet (buttonStyle)
		buttonE?.setStyleSheet (buttonStyle)
		buttonComma?.setStyleSheet (buttonStyle)
		buttonLeftParens?.setStyleSheet (buttonStyle)
		buttonRightParens?.setStyleSheet (buttonStyle)
		buttonInsertResult?.setStyleSheet (buttonStyle)
		buttonClear?.setStyleSheet (buttonStyle)
		buttonAbsolute?.setStyleSheet (buttonStyle)
		buttonSine?.setStyleSheet (buttonStyle)
		buttonCosine?.setStyleSheet (buttonStyle)
		buttonTangent?.setStyleSheet (buttonStyle)
		buttonArcsine?.setStyleSheet (buttonStyle)
		buttonArccosine?.setStyleSheet (buttonStyle)
		buttonArctangent?.setStyleSheet (buttonStyle)
		buttonLn?.setStyleSheet (buttonStyle)
		buttonSquareRoot?.setStyleSheet (buttonStyle)

		button1?.setStyleSheet (buttonStyle)
		button2?.setStyleSheet (buttonStyle)
		button3?.setStyleSheet (buttonStyle)
		button4?.setStyleSheet (buttonStyle)
		button5?.setStyleSheet (buttonStyle)
		button6?.setStyleSheet (buttonStyle)
		button7?.setStyleSheet (buttonStyle)
		button8?.setStyleSheet (buttonStyle)
		button9?.setStyleSheet (buttonStyle)
		button0?.setStyleSheet (buttonStyle)
		buttonDelete?.setStyleSheet (buttonStyle)
		buttonDot?.setStyleSheet (buttonStyle)
		buttonPi?.setStyleSheet (buttonStyle)
		buttonLog10?.setStyleSheet (buttonStyle)
		buttonEnter?.setStyleSheet (buttonStyle)

		setTitle("zCalculator \(App.release)")

		self.windowResizedHandler = { [weak self] (_ event : SQEvent) -> Void in
			guard let self = self else {
				return
			}
			let newWidth = self.width()
			let newHeight = self.height()
			print ("CalculatorWindow windowResizedHandler called, new size is \(newWidth)x\(newHeight).")
		}
		self.windowKeyPressHandler = { [weak self] (_ event : SQEvent) -> Void in
			guard let self = self else {
				return
			}

			var keyCode = event.key
			//print ("Key press: \(keyCode)")

			if keyCode == Qt.Key_Backspace || keyCode == Qt.Key_Delete {
				self.userPressedDelete()
				return
			}
			if keyCode == Qt.Key_Enter || keyCode == Qt.Key_Return {
				self.userPressedEnter()
				return
			}

			if keyCode >= 65 && keyCode <= 90 && 0 == (event.x & Qt.ShiftModifier) {
				keyCode += 32 // Convert upper case ASCII to lower case.
			}

			guard let ch = UnicodeScalar(keyCode) else {
				return
			}

			if (ch >= "0" && ch <= "9") || ch == "+" || ch == "." || ch == "-" || ch == "*" || ch == "/" || ch == "(" || ch == ")" || ch == "," {
				self.appendToExpression(String(ch))
			}
			else if ch == "=" {
				self.userPressedEnter()
			}
			else if ch >= "a" && ch <= "z" {
				self.appendToExpression(String(ch))
			}
		}
		self.windowKeyReleaseHandler = { (_ event : SQEvent) -> Void in
		}

		show()
	}

	public override func processEvent (_ event: SQEvent) -> Int
	{
		// This just handles windows events at the meta level.

		let eventType = event.type

		if eventType == QEventShow {
			let className = String(describing: type(of:self))
			print ("\(className) received Show event.")
			layoutUI ()
			return 0
		}

		return super.processEvent(event)
	}

	private func appendToExpression(_ str: String) {
		let nOpeningParens = expressionString.filter { $0 == "(" }.count
		let nClosingParens = expressionString.filter { $0 == ")" }.count
		let isDigit = str.allSatisfy(\.isWholeNumber)
		let isOperator = str == "*" || str == "/" || str == "+" 
		let last = expressionString.last
		let lastCharIsOperator = last == "*" || last == "/" || last == "+" 

		// Detect that the user is trying to enter a number with >1 dots.
		var foundDot = false
		for char in str + expressionString.reversed() {
			if char == "." {
				if foundDot {
					print ("Can't have multiple dots in number.")
					return
				} else {
					foundDot = true
				}
			}
			else if !char.isWholeNumber {
				break
			}
		}

		// RULE: Enforce a number of grammar to mostly eliminate
		// incorrect expressions during user input.
		// Final expression evaluation will catch the remaining syntax errors.
		//
		if str == "," && expressionString.hasSuffix(",") {
			print ("Can't have multiple adjacent commas.")
			return
		}
		if str == "-" && expressionString.hasSuffix("--") {
			print ("Can't have 3 adjacent minus signs.")
			return
		}
		if str == "." && (expressionString.hasSuffix(".") || lastCharIsOperator) {
			print ("Can't have two adjacent dots.")
			return
		}
		if str == ")" && expressionString.hasSuffix("(") {
			print ("Can't have empty parens.")
			return
		}
		if str == ")" && (nOpeningParens == 0 || nOpeningParens == nClosingParens) {
			print ("Can't have digit after a closing parens.")
			return
		}
		if isDigit && last == ")" {
			print ("Can't have digit after a closing parens.")
			return
		}
		if isOperator && last == "(" {
			print ("Can't have two operator after an opening parens.")
			return
		}
		if isOperator && lastCharIsOperator {
			print ("Can't have two adjacent operators.")
			return
		}
		if (str == "e" || str == "π") && !(expressionString == "" || last == "(" || last == "-" || lastCharIsOperator) {
			print ("Can't append constant.")
			return
		}
		expressionString += str
		expressionField?.setText(expressionString)
	}

	private func userPressed0 () {
		appendToExpression ("0")
		button0?.clearFocus()
	}
	private func userPressed1 () {
		appendToExpression ("1")
		button1?.clearFocus()
	}
	private func userPressed2 () {
		appendToExpression ("2")
		button2?.clearFocus()
	}
	private func userPressed3 () {
		appendToExpression ("3")
		button3?.clearFocus()
	}
	private func userPressed4 () {
		appendToExpression ("4")
		button4?.clearFocus()
	}
	private func userPressed5 () {
		appendToExpression ("5")
		button5?.clearFocus()
	}
	private func userPressed6 () {
		appendToExpression ("6")
		button6?.clearFocus()
	}
	private func userPressed7 () {
		appendToExpression ("7")
		button7?.clearFocus()
	}
	private func userPressed8 () {
		appendToExpression ("8")
		button8?.clearFocus()
	}
	private func userPressed9 () {
		appendToExpression ("9")
		button9?.clearFocus()
	}
	private func userPressedInsertResult () {
		let resultString = "\(lastResult)"
		appendToExpression (resultString)
		buttonInsertResult?.clearFocus()
	}
	private func userPressedRaiseToPower () {
		appendToExpression ("pow(")
		buttonPower?.clearFocus()
	}
	private func userPressedPi () {
		appendToExpression ("pi")
		buttonPi?.clearFocus()
	}
	private func userPressedSine () {
		appendToExpression ("sin(")
		buttonSine?.clearFocus()
	}
	private func userPressedArccosine () {
		appendToExpression ("acos(")
		buttonArccosine?.clearFocus()
	}
	private func userPressedAdd () {
		appendToExpression ("+")
		buttonAdd?.clearFocus()
	}
	private func userPressedArcsine () {
		appendToExpression ("asin(")
		buttonArcsine?.clearFocus()
	}
	private func userPressedArctangent () {
		appendToExpression ("atan(")
		buttonArctangent?.clearFocus()
	}
	private func userPressedCosine () {
		appendToExpression ("cos(")
		buttonCosine?.clearFocus()
	}
	private func userPressedDelete () {
		if expressionString != "" {
			expressionString = String(expressionString.dropLast())
			expressionField?.setText(expressionString)
		}
		buttonDelete?.clearFocus()
	}
	private func userPressedDivide () {
		appendToExpression ("/")
		buttonDiv?.clearFocus()
	}
	private func userPressedDot () {
		appendToExpression (".")
		buttonDot?.clearFocus()
	}
	private func userPressedNaturalLog () {
		appendToExpression ("ln(")
		buttonLn?.clearFocus()
	}
	private func userPressedLog10 () {
		appendToExpression ("log(")
		buttonLog10?.clearFocus()
	}
	private func userPressedMultiply () {
		appendToExpression ("*")
		buttonMul?.clearFocus()
	}
	private func userPressedSquareRoot () {
		appendToExpression ("sqrt(")
		buttonSquareRoot?.clearFocus()
	}
	private func userPressedComma () {
		appendToExpression (",")
		buttonComma?.clearFocus()
	}
	private func userPressedSubtract () {
		appendToExpression ("-")
		buttonSub?.clearFocus()
	}
	private func userPressedTangent () {
		appendToExpression ("tan(")
		buttonTangent?.clearFocus()
	}
	private func userPressedLeftParens () {
		appendToExpression ("(")
		buttonLeftParens?.clearFocus()
	}
	private func userPressedRightParens () {
		appendToExpression (")")
		buttonRightParens?.clearFocus()
	}
	private func userPressedAbsolute () {
		appendToExpression ("abs(")
		buttonAbsolute?.clearFocus()
	}
	private func userPressedE () {
		appendToExpression ("e")
		buttonE?.clearFocus()
	}
	private func userPressedEnter () {
		if expressionString.length > 0 {
			evaluate()
		}
		buttonEnter?.clearFocus()
	}
	private func userPressedClear () {
		// NOTE: Clear doesn't clear the last result unless the expression is already empty.
		if expressionString == "" {
			lastResult = 0.0
		}

		expressionString = ""
		expressionField?.setText("")
		buttonClear?.clearFocus()
	}

	private func evaluate()
	{
		let expression = Expression(expressionString,
    			constants: [
				"e": M_E
			],
			symbols: [
				.function("ln", arity: 1): { args in
					Foundation.log(args[0])
				},
				.function("log", arity: 1): { args in
					Foundation.log10(args[0])
				},
				.function("log2", arity: 1): { args in
					Foundation.log2(args[0])
				},
			    ]
		)
		var currentTapeText = tapeTextView?.toPlainText() ?? ""
		if currentTapeText.length > 0 {
			currentTapeText += "\n"
		}
		do {
			lastResult = try expression.evaluate()
			currentTapeText += "\(lastResult)"
		} catch {
			currentTapeText += "Error."
		}
		tapeTextView?.setText (currentTapeText)
		tapeTextView?.scrollToBottom ()

		expressionString = ""
		expressionField?.setText("")
	}
}
