import SwiftUI

// MARK: - LDRPinRow
struct LDRPinRow: View {
    // MARK: - property

    var title: String
    var onTap: (() -> Void)?
    
    // MARK: - view

    var body: some View {
        Button(
            action: {
                if let onTap = self.onTap {
                    onTap()
                }
            },
            label: {
                Text(title)
                .fixedSize(horizontal: false, vertical: true)
                .frame(height: 64)
                .lineLimit(2)
                .truncationMode(.tail)
            }
        )
    }
}

// MARK: - LDRPinRow_Previews
struct LDRPinRow_Previews: PreviewProvider {
    static var previews: some View {
        LDRPinRow(title: "Rails アプリでオンラインでカラムの削除やリネームを行うには - eagletmt's blog あいうえお かきくけこ さしすせそ たちつてと あいうえお かきくけこ さしすせそ たちつてと")
    }
}
