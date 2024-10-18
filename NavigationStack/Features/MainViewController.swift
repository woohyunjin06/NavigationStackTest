//
//  MainViewController.swift
//  NavigationStack
//
//  Created by 현진 on 10/18/24.
//

import UIKit
import SwiftUI

import ComposableArchitecture

struct MainView: View {
    
    let store: StoreOf<MainFeature>
    
    var body: some View {
        Group {
            Text("MainView")
            Button("Navigate to path1") {
                store.send(.navigateButtonTapped)
            }
        }
    }
}

final class MainViewController: UIHostingController<MainView> {

    private let store: StoreOf<MainFeature>
    init(store: StoreOf<MainFeature>) {
        self.store = store
        super.init(rootView: MainView(store: store))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.send(.onAppear)
    }
    
    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

@Reducer
struct MainFeature {
    
    @ObservableState
    struct State: Equatable {
    }

    public enum Action {
        case onAppear
        case navigateButtonTapped
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            case .navigateButtonTapped:
                return .none
            }
        }
    }
}
