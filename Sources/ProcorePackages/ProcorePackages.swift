@main
public struct ProcorePackages {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(ProcorePackages().text)
    }
}
