//
//  Lexer.swift
//  Contains the Lexer class or struct, responsible for tokenizing the JavaScript code.
//
//  Created by الشيخ عزام on 22/08/2024.
//

import Foundation

class Lexer {
    private let input: String
    private var currentIndex: String.Index

    init(input: String) {
        self.input = input
        self.currentIndex = input.startIndex
    }

    func nextToken() -> Token {
        skipWhitespace()

        guard currentIndex < input.endIndex else {
            return .eof
        }

        let currentChar = input[currentIndex]

        // Handle different cases based on the current character
        if isLetter(currentChar) {
            return readIdentifierOrKeyword()
        } else if isDigit(currentChar) {
            return readNumber()
        } else if currentChar == "\"" {
            return readString()
        } else if isOperator(currentChar) {
            return readOperator()
        } else {
            // Handle punctuation or any other single character tokens
            advanceIndex()
            return .punctuation(String(currentChar))
        }
    }

    // Helper functions for handling specific token types

    private func readIdentifierOrKeyword() -> Token {
        var identifier = ""
        while currentIndex < input.endIndex && isLetterOrDigit(input[currentIndex]) {
            identifier.append(input[currentIndex])
            advanceIndex()
        }

        // Check if the identifier is a keyword
        if isKeyword(identifier) {
            return .keyword(identifier)
        }

        return .identifier(identifier)
    }
    
    private func readNumber() -> Token {
        var numberString = ""
        var hasDecimalPoint = false
        
        while currentIndex < input.endIndex && (isDigit(input[currentIndex]) || (input[currentIndex] == "." && !hasDecimalPoint)) {
            if input[currentIndex] == "." {
                hasDecimalPoint = true
            }
            numberString.append(input[currentIndex])
            advanceIndex()
        }
        
        return .number(Double(numberString) ?? 0.0)
    }

    private func readString() -> Token {
        var string = ""
        advanceIndex() // Skip the opening quote

        while currentIndex < input.endIndex && input[currentIndex] != "\"" {
            string.append(input[currentIndex])
            advanceIndex()
        }

        advanceIndex() // Skip the closing quote
        return .string(string)
    }

//    private func readOperator() -> Token {
//        let op = String(input[currentIndex])
//        advanceIndex()
//        return .operator(op)
//    }
    
    private func readOperator() -> Token {
        let start = currentIndex
        
        // Check for multi-character operators first
        let possibleTwoCharOperator = peekNext(2)
        if isMultiCharacterOperator(possibleTwoCharOperator) {
            advanceIndex(by: 2)
            return .operator(possibleTwoCharOperator)
        }
        
        let possibleOneCharOperator = String(input[start])
        advanceIndex()
        return .operator(possibleOneCharOperator)
    }

    private func isMultiCharacterOperator(_ op: String) -> Bool {
        let multiCharOperators = ["==", "!=", ">=", "<=", "&&", "||"]
        return multiCharOperators.contains(op)
    }

    // Helper function to peek at the next n characters
    private func peekNext(_ n: Int) -> String {
        guard input.distance(from: currentIndex, to: input.endIndex) >= n else {
            return ""
        }
        let endIndex = input.index(currentIndex, offsetBy: n)
        return String(input[currentIndex..<endIndex])
    }

    // Utility functions

    private func skipWhitespace() {
        while currentIndex < input.endIndex && input[currentIndex].isWhitespace {
            advanceIndex()
        }
    }

    private func advanceIndex(by n: Int = 1) {
        currentIndex = input.index(currentIndex, offsetBy: n)
    }

    private func isLetter(_ char: Character) -> Bool {
        return char.isLetter || char == "_"
    }

    private func isDigit(_ char: Character) -> Bool {
        return char.isNumber
    }

    private func isLetterOrDigit(_ char: Character) -> Bool {
        return isLetter(char) || isDigit(char)
    }

    private func isOperator(_ char: Character) -> Bool {
        return "+-*/=".contains(char)
    }

    private func isKeyword(_ identifier: String) -> Bool {
        let keywords = ["let", "var", "function", "if", "else", "return"]
        return keywords.contains(identifier)
    }
}
