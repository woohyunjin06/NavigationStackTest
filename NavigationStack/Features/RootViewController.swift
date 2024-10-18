//
//  ViewController.swift
//  NavigationStack
//
//  Created by 현진 on 10/18/24.
//

import UIKit
import SwiftUI

import ComposableArchitecture

final class RootViewController: NavigationStackController {
    
    private var store: StoreOf<RootFeature>?
    
    convenience init(store: StoreOf<RootFeature>) {
        @UIBindable var store = store
        self.init(
            path: $store.scope(state: \.path, action: \.path),
            root: {
                MainViewController(store: store.scope(state: \.root, action: \.root))
            },
            destination: { store in
                switch store.case {
                case .path1:
                    return UIHostingController(
                        rootView: Group {
                            Text("Path 1")
                        }
                    )
                }
            }
        )
        self.store = store
    }
}

@Reducer
struct RootFeature {
    
    @ObservableState
    struct State: Equatable {
        public var root: MainFeature.State
        public var path: StackState<Path.State>

        public init(root: MainFeature.State, path: StackState<Path.State>) {
            self.root = root
            self.path = path
        }
    }

    public enum Action {
        case root(MainFeature.Action)
        case path(StackActionOf<Path>)
    }

    @Reducer(state: .equatable)
    public enum Path {
        case path1
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .root(.navigateButtonTapped):
                state.path.append(.path1)
                return .none
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)

        Scope(state: \.root, action: \.root) {
            MainFeature()
        }
    }
}
