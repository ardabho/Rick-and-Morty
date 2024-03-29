//
//  RMSettingsView.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 3.03.2024.
//

import SwiftUI

struct RMSettingsView: View {
    private let viewModel: RMSettingsViewVM
    
    init(viewModel: RMSettingsViewVM) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width:20, height: 20)
                        .foregroundStyle(.bar)
                        .padding(8)
                        .background(Color(uiColor: viewModel.backgroundColor))
                        .clipShape(.rect(cornerRadius: 8))
                }
                Text(viewModel.title)
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.vertical, 2)
            .onTapGesture {
                viewModel.onTapHandler(viewModel.type)
            }
        }
    }
}

#Preview {
    RMSettingsView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
        return RMSettingsCellVM(type: $0) { option in
            
        }
    })))
}
