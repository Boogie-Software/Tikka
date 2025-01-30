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

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tikka/presentation/presenter.dart';
import 'package:tikka/presentation/view_event.dart';
import 'package:tikka/presentation/view_state.dart';
import 'package:tikka/presentation/view_state_observer.dart';
import 'package:injector/injector.dart';

import 'presenter_test.mocks.dart';

class TestViewState extends ViewState {}

class TestViewEvent extends ViewEvent {}

class TestPresenter extends Presenter<TestViewEvent, TestViewState> {
  TestPresenter(super.initialState);
}

@GenerateMocks([ViewStateObserver])
void main() {
  late Presenter<TestViewEvent, TestViewState> presenter;
  late MockViewStateObserver<TestViewState> mockViewStateObserver;

  setUp(() {
    mockViewStateObserver = MockViewStateObserver<TestViewState>();
    presenter = TestPresenter(TestViewState());
    presenter.viewStateObserver = mockViewStateObserver;

    // Mock dependency injection
    final injector = Injector.appInstance;
    injector.clearAll();
    injector.registerDependency<String>(() { return "Mocked dependency"; });
  });

  test('Initial view state is correct', () {
    expect(presenter.viewState, isA<TestViewState>());
  });

  test('onViewEvent does nothing by default', () {
    // No expectations, just verifying no errors are thrown
    presenter.onViewEvent(TestViewEvent());
  });

  test('emit updates viewState and notifies observer when view is active', () {
    presenter.isViewActive = true;
    final newViewState = TestViewState();
    presenter.emit(newViewState);

    verify(mockViewStateObserver.onViewStateChanged(newViewState)).called(1);
    expect(presenter.viewState, newViewState);
  });


  test('emit updates viewState but does not notify observer when view is inactive', () {
    presenter.isViewActive = false;
    final newViewState = TestViewState();
    presenter.emit(newViewState);

    verifyNever(mockViewStateObserver.onViewStateChanged(newViewState));
    expect(presenter.viewState, newViewState);
  });


  test('get retrieves dependency from injector', () {

    final result = presenter.get<String>();
    expect(result, equals("Mocked dependency"));
  });
}

