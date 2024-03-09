import RegexBuilder

private let hex = CharacterClass(
    ("0"..."9"),
    ("a"..."f")
)
private let num = Regex {
    hex
    hex
}
let macAddressRegex = Regex {
    Capture {
        num
        ":"
        num
        ":"
        num
        ":"
        num
        ":"
        num
        ":"
        num
    }
}
