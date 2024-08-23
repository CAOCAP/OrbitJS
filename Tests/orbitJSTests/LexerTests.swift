//
//  LexerTests.swift
//  Unit tests for the Lexer class, ensuring it correctly tokenizes different JavaScript code snippets.
//
//  Created by الشيخ عزام on 22/08/2024.
//

import XCTest
@testable import orbitJS

class LexerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Any setup code can go here
    }

    override func tearDown() {
        // Any cleanup code can go here
        super.tearDown()
    }
    
    func testSingleKeyword() {
        let input = "let"
        var lexer = Lexer(input: input)
        let token = lexer.nextToken()
        XCTAssertEqual(token, .keyword("let"))
    }

    func testIdentifier() {
        let input = "myVariable"
        var lexer = Lexer(input: input)
        let token = lexer.nextToken()
        XCTAssertEqual(token, .identifier("myVariable"))
    }

    func testNumberLiteral() {
        let input = "12345"
        var lexer = Lexer(input: input)
        let token = lexer.nextToken()
        XCTAssertEqual(token, .number(12345))
    }

    func testStringLiteral() {
        let input = "\"hello world\""
        var lexer = Lexer(input: input)
        let token = lexer.nextToken()
        XCTAssertEqual(token, .string("hello world"))
    }

    func testOperators() {
        let input = "+ - * / ="
        var lexer = Lexer(input: input)

        XCTAssertEqual(lexer.nextToken(), .operator("+"))
        XCTAssertEqual(lexer.nextToken(), .operator("-"))
        XCTAssertEqual(lexer.nextToken(), .operator("*"))
        XCTAssertEqual(lexer.nextToken(), .operator("/"))
        XCTAssertEqual(lexer.nextToken(), .operator("="))
    }

    func testPunctuation() {
        let input = "(){}[],;"
        var lexer = Lexer(input: input)

        XCTAssertEqual(lexer.nextToken(), .punctuation("("))
        XCTAssertEqual(lexer.nextToken(), .punctuation(")"))
        XCTAssertEqual(lexer.nextToken(), .punctuation("{"))
        XCTAssertEqual(lexer.nextToken(), .punctuation("}"))
        XCTAssertEqual(lexer.nextToken(), .punctuation("["))
        XCTAssertEqual(lexer.nextToken(), .punctuation("]"))
        XCTAssertEqual(lexer.nextToken(), .punctuation(","))
        XCTAssertEqual(lexer.nextToken(), .punctuation(";"))
    }

    func testComplexExpression() {
        let input = "let x = 42 + 3.14;"
        var lexer = Lexer(input: input)

        XCTAssertEqual(lexer.nextToken(), .keyword("let"))
        XCTAssertEqual(lexer.nextToken(), .identifier("x"))
        XCTAssertEqual(lexer.nextToken(), .operator("="))
        XCTAssertEqual(lexer.nextToken(), .number(42))
        XCTAssertEqual(lexer.nextToken(), .operator("+"))
        XCTAssertEqual(lexer.nextToken(), .number(3.14))
        XCTAssertEqual(lexer.nextToken(), .punctuation(";"))
        XCTAssertEqual(lexer.nextToken(), .eof)
    }
    
    func testMultiCharacterOperators() {
        let input = "== != >= <= && ||"
        var lexer = Lexer(input: input)

        XCTAssertEqual(lexer.nextToken(), .operator("=="))
        XCTAssertEqual(lexer.nextToken(), .operator("!="))
        XCTAssertEqual(lexer.nextToken(), .operator(">="))
        XCTAssertEqual(lexer.nextToken(), .operator("<="))
        XCTAssertEqual(lexer.nextToken(), .operator("&&"))
        XCTAssertEqual(lexer.nextToken(), .operator("||"))
    }
    
    func testSingleLineComment() {
        let input = "// this is a comment\nlet x = 42"
        var lexer = Lexer(input: input)

        XCTAssertEqual(lexer.nextToken(), .keyword("let"))
        XCTAssertEqual(lexer.nextToken(), .identifier("x"))
        XCTAssertEqual(lexer.nextToken(), .operator("="))
        XCTAssertEqual(lexer.nextToken(), .number(42))
    }
    
    func testMultiLineComment() {
        let input = "/* this is a \n multi-line comment */\nlet y = 3.14"
        var lexer = Lexer(input: input)

        XCTAssertEqual(lexer.nextToken(), .keyword("let"))
        XCTAssertEqual(lexer.nextToken(), .identifier("y"))
        XCTAssertEqual(lexer.nextToken(), .operator("="))
        XCTAssertEqual(lexer.nextToken(), .number(3.14))
    }
    
    func testStringEscapes() {
        let input = "\"Hello, \\\"world\\\"!\""
        var lexer = Lexer(input: input)
        let token = lexer.nextToken()
        XCTAssertEqual(token, .string("Hello, \"world\"!"))
    }
    
    func testNumberFollowedByIdentifier() {
        let input = "3abc"
        var lexer = Lexer(input: input)

        XCTAssertEqual(lexer.nextToken(), .number(3))
        XCTAssertEqual(lexer.nextToken(), .identifier("abc"))
    }
    
    func testInvalidToken() {
        let input = "@invalid"
        var lexer = Lexer(input: input)

        let token = lexer.nextToken()
        // Depending on how you want to handle invalid tokens
        XCTAssertEqual(token, .identifier("@invalid"))
    }
    
    func testComplexExpressionWithParentheses() {
        let input = "let result = (42 + 3) * (5 - 2);"
        var lexer = Lexer(input: input)

        XCTAssertEqual(lexer.nextToken(), .keyword("let"))
        XCTAssertEqual(lexer.nextToken(), .identifier("result"))
        XCTAssertEqual(lexer.nextToken(), .operator("="))
        XCTAssertEqual(lexer.nextToken(), .punctuation("("))
        XCTAssertEqual(lexer.nextToken(), .number(42))
        XCTAssertEqual(lexer.nextToken(), .operator("+"))
        XCTAssertEqual(lexer.nextToken(), .number(3))
        XCTAssertEqual(lexer.nextToken(), .punctuation(")"))
        XCTAssertEqual(lexer.nextToken(), .operator("*"))
        XCTAssertEqual(lexer.nextToken(), .punctuation("("))
        XCTAssertEqual(lexer.nextToken(), .number(5))
        XCTAssertEqual(lexer.nextToken(), .operator("-"))
        XCTAssertEqual(lexer.nextToken(), .number(2))
        XCTAssertEqual(lexer.nextToken(), .punctuation(")"))
        XCTAssertEqual(lexer.nextToken(), .punctuation(";"))
        XCTAssertEqual(lexer.nextToken(), .eof)
    }
    
    func testEmptyInput() {
        let input = ""
        var lexer = Lexer(input: input)

        XCTAssertEqual(lexer.nextToken(), .eof)
    }
}


