// Copyright 2025 Boogie Software Oy. All rights reserved.
//
// This file is licensed to you under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License. You may obtain a copy
// of the License at http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distributed under
// the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
// OF ANY KIND, either express or implied. See the License for the specific language
// governing permissions and limitations under the License.

import 'package:injector/injector.dart';
import 'package:tikka/presentation/view_event.dart';
import 'package:tikka/presentation/view_state.dart';
import 'package:tikka/presentation/view_state_observer.dart';

/// Abstract class for Presenter components in Presentation layer.
abstract class Presenter<E extends ViewEvent, S extends ViewState> {

  late S _viewState;
  bool isViewActive = false;

  /// A [ViewStateObserver] to notify about a changed [ViewState]
  late ViewStateObserver<S> viewStateObserver;

  /// Get the current [ViewState]
  S get viewState => _viewState;

  /// Gets the reference to [ViewContext]
  //ViewContext<S> get viewContext => _viewContext;
 
  /// Constructs a new instance of [Presenter] with a given initial [ViewState]
  /// and [ViewContext].
  Presenter(this._viewState);

  /// Receives and handles a [ViewEvent] thas is passed by a [Controller] and
  /// originally emitted by a View in the UI layer.
  void onViewEvent(E event) {
    // By default do nothing
  }

  /// Emits the given [ViewState] to View via the assigned [ViewStateObserver].
  void emit(S viewState) {
    _viewState = viewState;
    if (isViewActive) viewStateObserver.onViewStateChanged(viewState);
  }

    /// A utility method for simple dependency injection.
  T get<T>({String dependencyName = ""}) => Injector.appInstance.get<T>(dependencyName: dependencyName);
}