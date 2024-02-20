import Foundation

internal struct ParsedFormat {
    
    enum FormatComponent {
        case literal(String)
        case format(Character, Int)
        case template(Character, Int)
        
        var isTemplate: Bool {
            if case .template = self { return true }
            return false
        }
        
        var unit: Calendar.Component? {
            switch self {
                case .literal:
                    return nil
                case .format(let char, _):
                    return Calendar.Component(formatCharacter: char).unwrap("Somehow got an invalid format character while parsing?")
                case .template(let char, _):
                    return Calendar.Component(formatCharacter: char).unwrap("Somehow got an invalid template character while parsing?")
            }
        }
        
        func compact(with subsequent: FormatComponent) -> (FormatComponent, FormatComponent?) {
            switch (self, subsequent) {
                case (.literal(let left), .literal(let right)):
                    return (.literal(left + right), nil)
                    
                case (.format(let leftChar, let leftCount), .format(let rightChar, let rightCount)):
                    if leftChar == rightChar {
                        return (.format(leftChar, leftCount + rightCount), nil)
                    }
                    break
                    
                case (.template(let leftChar, let leftCount), .template(let rightChar, let rightCount)):
                    if leftChar == rightChar {
                        return (.template(leftChar, leftCount + rightCount), nil)
                    }
                    break
                    
                default:
                    break
            }
            return (self, subsequent)
        }
    }
    
    var components: Array<FormatComponent>
    
    var isTemplate: Bool { components.contains(where: \.isTemplate) }
    
    init(formatString: String) throws {
        var components = Array<FormatComponent>()
        
        var isEscaped = false
        var previousChar: Character?
        
        for currentChar in formatString {
            if currentChar == SingleQuote {
                if isEscaped && previousChar == SingleQuote {
                    // double-escaped single-quote
                    components.append(.literal(String(SingleQuote)))
                }
                isEscaped.toggle()
            } else if isEscaped {
                components.append(.literal(String(currentChar)))
            } else {
                if templateCharacters.contains(currentChar) {
                    // it's a template character
                    components.append(.template(currentChar, 1))
                } else if formatCharacters.contains(currentChar) {
                    // it's a format character
                    components.append(.format(currentChar, 1))
                } else {
                    // it's a literal character
                    components.append(.literal(String(currentChar)))
                }
            }
            
            previousChar = currentChar
        }
        
        var compacted = Array<FormatComponent>()
        
        if var current = components.first {
            for next in components.dropFirst() {
                let (left, right) = current.compact(with: next)
                
                if let right {
                    compacted.append(left)
                    current = right
                } else {
                    current = left
                }
            }
            
            compacted.append(current)
        }
        
        if isEscaped || compacted.isEmpty {
            // if we still think things are escaped, then we have imbalanced quotes and an invalid format string
            throw TimeError.invalidFormatString(formatString)
        }
        
        self.components = compacted
    }
}

private let templateCharacters: Set<Character> = ["j", "J", "C"]
private let formatCharacters: Set<Character> = ["G", "y", "Y", "u", "U", "r", "Q", "q", "M", "L", "w", "W", "d", "D", "F", "g", "E", "e", "c", "a", "b", "B", "h", "H", "k", "K", "m", "s", "S", "A", "z", "Z", "O", "v", "V", "X", "x"]
private let SingleQuote: Character = "'"
