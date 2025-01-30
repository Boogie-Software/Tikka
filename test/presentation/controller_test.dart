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
import 'package:tikka/presentation/controller.dart';
import 'package:tikka/presentation/presenter.dart';
import 'package:tikka/presentation/view_event.dart';
import 'package:tikka/presentation/view_state.dart';
import 'package:injector/injector.dart';

import 'controller_test.mocks.dart';

class TestViewState extends ViewState {}

class TestViewEvent extends ViewEvent {}

class TestPresenter extends Presenter<TestViewEvent, TestViewState> {
  TestPresenter(super.initialState);
}

class TestController extends Controller<TestViewEvent, TestPresenter> {
  TestController(super.presenter);
}

@GenerateMocks([TestPresenter])
void main() {
  late TestController controller;
  late MockTestPresenter mockPresenter;

  setUp(() {
    mockPresenter = MockTestPresenter();
    controller = TestController(mockPresenter);

    // Mock dependency injection
    final injector = Injector.appInstance;
    injector.clearAll();
    injector.registerDependency<String>(() { return "Mocked dependency"; });
  });

  test('onViewInit sets presenter.isViewActive to true', () {
    controller.onViewInit();
    verify(mockPresenter.isViewActive = true).called(1);
  });

  test('onViewActivate sets presenter.isViewActive to true', () {
    controller.onViewActivate();
    verify(mockPresenter.isViewActive = true).called(1);

  });

  test('onViewDeactivate sets presenter.isViewActive to false', () {
    controller.onViewDeactivate();
    verify(mockPresenter.isViewActive = false).called(1);
  });

  test('onViewDispose sets presenter.isViewActive to false', () {
    controller.onViewDispose();
    verify(mockPresenter.isViewActive = false).called(1);
  });

  test('get retrieves dependency from injector', () {
    final result = controller.get<String>();
    expect(result, equals("Mocked dependency"));
  });

    test('other lifecycle methods do nothing by default', () {
      //No expectations, just verifying no errors are thrown
    controller.onViewCreate();
    controller.onViewUpdate();
    controller.onViewReassemble();
  });
}

