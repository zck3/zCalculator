
# zCalculator

By Zack T Smith, 3 at zs3 dot me

This is a simple calculator app that is basically my port of
my "Eval" iOS app, which I coded in Objective-C, to Swift and Qt 6.

However, rather than use my own C-based expression evaluator,
I'm utilizing Nick Lockwood's Expression framework.

## Dependencies

This app depends on:

* The Qt 6 libraries and utilities.
* The Swift 6 compiler with Swift Package Manager.
* A C++ compiler such as `clang++` or `g++`.

Run the `configure` script to verify these are installed.

## Build and run

* To build the app, type `swift build`.
* To run the compiled app, type `swift run`.
* To clean, type `swift package clean`.

## Changes

* 0.1 Basic application template, copied from my SampleSwiftQtApp project.
* 0.2 Translated Objective-C UI code from my closed-source Eval iOS calculator project.
* 0.3 Using Expression framework for expression evaluation.
* 0.4 Improved GUI to allow keyboard entry.
* 0.5 Minor fix for SwiftQt 0.28.

