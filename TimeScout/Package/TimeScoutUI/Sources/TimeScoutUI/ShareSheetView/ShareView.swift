//
//  ShareView.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore

public struct ShareView: View {
    
    private let linkURL: URL
    
    public init(linkURL: URL) {
        self.linkURL = linkURL
    }

    public var body: some View {
        ShareLink(item: linkURL) {
            Image.SFSymbols.share
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
        }
    }
}

// MARK: - Preview

struct ShareView_Previews: PreviewProvider {

    static var previews: some View {
        ZStack {
            Color.blue
            ShareView(linkURL: URL("")!)
        }
    }
}

// MARK: - iOS15 system share sheet

private struct ActivityViewController: UIViewControllerRepresentable {

    @Binding var activityItems: [Any]
    var excludedActivityTypes: [UIActivity.ActivityType]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems,
                                                  applicationActivities: nil)

        controller.excludedActivityTypes = excludedActivityTypes

        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
}

private struct ShareSheetModifer: ViewModifier {
    @State private var showShareSheet: Bool
    @State private var shareSheetItems: [Any]
    
    init(showShareSheet: Bool = false, shareSheetItems: [Any] = []) {
        self.showShareSheet = showShareSheet
        self.shareSheetItems = shareSheetItems
    }

    func body(content: Content) -> some View {
        content
            .contextMenu {
                Button(action: {
                    self.showShareSheet.toggle()
                }) {
                    Image.SFSymbols.share
                }
            }
            .sheet(isPresented: $showShareSheet, content: {
                ActivityViewController(activityItems: self.$shareSheetItems)
            })
    }
}

extension View {

    func shareSheet(items: [Any], excludedActivityTypes: [UIActivity.ActivityType]? = nil) -> some View {
        self.modifier(ShareSheetModifer(shareSheetItems: items))
    }
}
