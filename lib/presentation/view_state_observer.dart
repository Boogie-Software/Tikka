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

import 'package:tikka/presentation/view_state.dart';
import 'package:tikka/presentation/presenter.dart';

/// [ViewStateObserver] defines an observer interface for receiving 
/// updated [ViewState]s. Instances of [ViewState] are emitted by
/// a [Presenter] and received by a View component (in Framework layer)
/// implementing the interface. Concrete implemenations of [ViewStateObserver]
/// are placed to Presentation layer.
abstract class ViewStateObserver<S extends ViewState> {

  /// Invoked when a [state] changes.
  void onViewStateChanged(S state);
}
