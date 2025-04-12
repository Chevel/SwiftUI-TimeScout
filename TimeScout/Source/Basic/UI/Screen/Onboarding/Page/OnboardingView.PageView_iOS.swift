//
//  OnboardingImagesView.swift
//  TimeScout
//
//  Created by Matej on 22. 11. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

extension OnboardingView {

    struct PageView: View {
        let page: OnboardingView.Page.Data

        var body: some View {
            VStack(alignment: .center, spacing: 0) {
                header
                title
                subtitle
                Spacer()
            }
            .padding(.horizontal, 8)
        }
    }
}

// MARK: - UI

private extension OnboardingView.PageView {
    
    var header: some View {
        page.image
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2, alignment: .center)
            .clipped()
    }

    var title: some View {
        Text(page.title)
            .multilineTextAlignment(.center)
            .font(Font.Pallete.Onboarding.title)
            .foregroundStyle(Color.Pallete.Foreground.primary)
            .padding(.top, 40)
    }

    @ViewBuilder
    var subtitle: some View {
        if let subTitle = page.subTitle {
            Text(subTitle)
                .multilineTextAlignment(.center)
                .font(Font.Pallete.Onboarding.subtitle)
                .foregroundStyle(Color.Pallete.Foreground.primary)
                .padding(.top, 16)
        } else {
            EmptyView()
        }
    }

    var bulletpointSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(page.description ?? [], id: \.self) { description in
                HStack(alignment: .center) {
                    Text(description)
                        .font(Font.Pallete.Onboarding.title)
                        .foregroundStyle(Color.Pallete.Foreground.primary)
                        .shadow(color: .black, radius: 5, x: 3, y: 3)
                }
            }
        }
    }
}
