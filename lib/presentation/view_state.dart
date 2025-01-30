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

import 'package:tikka/presentation/presenter.dart';

/// [ViewState] provides an abstract class for implementing View State components.
/// A View State encapsulated all the data needed to render Widgets in a page or
/// screen. Instances of [ViewState] are modified and emitted to UI by a [Presenter].
///  
/// An implementation of [ViewState] should be an immutable class.
///
/// Concreate implementations of [ViewState] are placed to Presentation layer.
abstract class ViewState {}