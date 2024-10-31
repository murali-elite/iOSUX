//
//  ContentView.swift
//  IOSUXTestApp
//
//  Created by Murali moorthy on 8/1/24.
//

import SwiftUI

struct ContentView: View {
   @State var isPresent: Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!sdkhgkdfsjhgkddsgdsfgdsfgfsjh")
                
                Button("Tap .. !") {
                    isPresent.toggle()
                }
            }
            .padding()
        
        }
        
       
           
        }
        .showLoader($isPresent) {
            isPresent.toggle()
        }
    }
}
#Preview {
    //TextLableView()
    TagView(tags: [
        TagViewItem(title: "I accept the"),
        TagViewItem(title: "terms & conditons", isUnderLine: true),
        TagViewItem(title: "&"),
        TagViewItem(title: "privacy policy", isUnderLine: true),
    ])
}

struct TagViewItem: Hashable {
    var title: String
    var isUnderLine: Bool = false
}
struct TagView: View {
@State var tags: [TagViewItem]
@State private var totalHeight = CGFloat.zero       // << variant for ScrollView/List //    = CGFloat.infinity   // << variant for VStack
var body: some View {
    VStack {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }
    .frame(height: totalHeight)// << variant for ScrollView/List
    //.frame(maxHeight: totalHeight) // << variant for VStack
}

private func generateContent(in g: GeometryProxy) -> some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    return ZStack(alignment: .topLeading) {
        ForEach(tags.indices) { index in
            item(for: tags[index].title)
                .underline(color: tags[index].isUnderLine ? .black : .clear)
                .padding([.horizontal, .vertical], 2)
                .alignmentGuide(.leading, computeValue: { dimension in
                    if (abs(width - dimension.width) > g.size.width) {
                        width = 0
                        height -= dimension.height
                    }
                    let result = width
                    if tags[index].title == self.tags.last!.title {
                        width = 0 //last item
                    } else {
                        width -= dimension.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: { dimension in
                    let result = height
                    if tags[index].title == self.tags.last!.title {
                        height = 0 // last item
                    }
                    return result
                }).onTapGesture {
                   
                }
        }
    }.background(viewHeightReader($totalHeight))
}

private func item(for text: String) -> some View {
    Text(text)
        .foregroundColor(Color.red)
        .lineLimit(1)
        .frame(height: 36)
}

private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
    return GeometryReader { geometry -> Color in
        let rect = geometry.frame(in: .local)
        DispatchQueue.main.async {
            binding.wrappedValue = rect.size.height
        }
        return .clear
    }
}
}
