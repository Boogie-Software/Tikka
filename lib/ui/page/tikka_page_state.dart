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

import 'package:flutter/material.dart';
import 'package:tikka/presentation/controller.dart';
import 'package:tikka/presentation/view_state.dart';
import 'package:tikka/presentation/view_state_observer.dart';
import 'package:tikka/ui/page/tikka_page.dart';

/// [TikkaPageState] provides a base class for concrete implementations of Flutter´s [State] wigget
/// that can make use of the Presentation Layer design pattern and components provided in Tikka.
/// A [State] widget implementation derived from [TikkaPageState] have access to the injected [Controller],
/// and can use it to emit [ViewStateEvent] based events to the [Controller]. In addition, the [State] widget
///  can provide lifecycle events to the attached [Controller].
abstract class TikkaPageState<C extends Controller, S extends ViewState, W extends TikkaPage<C>> 
  extends State<W> implements ViewStateObserver<S> {

  late S viewState;
  late C controller;

  /// Function that is used to inject instances of [ViewState] to a [State] of a [StatefullWidget]
  @override
  void onViewStateChanged(S viewState) {
    this.viewState = viewState;
    setState(() {});  
  }

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    controller.onViewInit();
    viewState = controller.presenter.viewState as S;
    controller.presenter.viewStateObserver = this;
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    controller.onViewDispose();
  }

  @mustCallSuper
  @override
  void activate() {
    super.activate();
    controller.onViewActivate();
  }

  @mustCallSuper
  @override
  void deactivate() {
    super.deactivate();
    controller.onViewDeactivate();
  }

  @mustCallSuper
  @override
  void reassemble() {
    super.reassemble();
    controller.onViewReassemble();
  }

  @mustCallSuper
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    controller.onViewUpdate();
  }
} 
