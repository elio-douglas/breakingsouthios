import SwiftUI
import SwiftData

struct ShoppingItemRow: View {
    @Bindable var item: ShoppingItem

    var body: some View {
        HStack {
            Button {
                item.isChecked.toggle()
            } label: {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(item.isChecked ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(.plain)

            Text(item.name)
                .strikethrough(item.isChecked)
                .foregroundStyle(item.isChecked ? .secondary : .primary)

            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            item.isChecked.toggle()
        }
    }
}
