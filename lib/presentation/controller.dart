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
import 'package:tikka/domain/use_case/use_case_subscriber.dart';
import 'package:tikka/presentation/presenter.dart';
import 'package:tikka/presentation/view_event.dart';

/// [Controller] defines an interfance for Controller components in Presentation layer.
abstract class Controller<E extends ViewEvent, P extends Presenter> implements UseCaseSubscriber {

  final P presenter;

  /// Constructor for [Controller] that is used to inject dependencies to
  /// to a [Presenter] and [ViewContext].
  Controller(this.presenter);

  /// Receives and handles an [event] emitted by a View in the UI layer.
  onViewEvent(E event) {}

  /// Upon creation of the View, which is a [StatefulWidget], its constructor 
  /// is called, which initializes View the widget. The createState() 
  /// method is then invoked, which creates the state object for the widget.
  onViewCreate() {}

  /// Called after the View is inserted into the widget tree, when 
  /// the state object is created for the first time.
  onViewInit() {
    presenter.isViewActive = true;
  }

  /// Called when the View is rebuilt with updated properties. 
  onViewUpdate() {}

  /// Called when the View is re-inserted into the widget after being removed
  /// by deactivation.
  onViewActivate() {
    presenter.isViewActive = true;
  }

  /// Called when the View is removed from the widget tree but might be 
  /// inserted again.
  onViewDeactivate() {
    presenter.isViewActive = false;
  }

  /// Called when the View is removed from the widget tree permanently, 
  /// allowing you to release resources held by the View. 
  onViewDispose() {
    presenter.isViewActive = false;
  }

  /// Called when the View is reassembled among reassembling the application
  /// during a hot reload.
  onViewReassemble() {}

  /// A utility method for simple dependency injection.
  T get<T>({String dependencyName = ""}) => Injector.appInstance.get<T>(dependencyName: dependencyName);
}
