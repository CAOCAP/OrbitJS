# orbitJS

**orbitJS** is an open-source Swift library for parsing JavaScript code, generating an Abstract Syntax Tree (AST), and providing a simple and intuitive interface for AST manipulation. The library also includes functionality to regenerate JavaScript code from the modified AST, making it a powerful tool for code analysis, transformation, and generation in Swift.

## Features

- **JavaScript Parsing:** Converts JavaScript code strings into a well-structured AST using a Swift-based parser.
- **AST Manipulation:** Traverse and modify the AST with a developer-friendly API.
- **Code Generation:** Generate syntactically correct JavaScript code from the modified AST.
- **Robust Testing:** Includes extensive test cases to ensure reliable parsing and AST manipulation.

## Getting Started

### Installation

You can integrate `orbitJS` into your Swift project using Swift Package Manager (SPM). Add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/CAOCAP/orbitJS.git", from: "1.0.0")
]
```

### Usage

#### Parsing JavaScript

```swift
import orbitJS

let jsCode = "let x = 42 + 3.14;"
var lexer = Lexer(input: jsCode)
var parser = Parser(lexer: lexer)

let ast = parser.parseProgram()
print(ast)
```

#### Manipulating the AST

```swift
// Example of traversing and modifying the AST
// (Implementation depends on your specific use case)
```

#### Code Generation

```swift
// Generate JavaScript code from the modified AST
let generatedCode = CodeGenerator.generate(ast)
print(generatedCode)
```

## Running Tests

`orbitJS` includes a suite of unit tests to ensure the robustness of the lexer, parser, and code generator. You can run the tests using Xcode or via the terminal:

```bash
swift test
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.

Please see the [CONTRIBUTING.md](CONTRIBUTING.md) file for more details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by Esprima, Acorn, and Babel for JavaScript parsing.
- Thanks to the open-source community for their valuable contributions.
