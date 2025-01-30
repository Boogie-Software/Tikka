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

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injector/injector.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tikka/domain/entity/state.dart';
import 'package:tikka/domain/use_case/use_case_bloc.dart';
import 'package:tikka/domain/use_case/use_case_intent.dart';
import 'package:tikka/domain/use_case/use_case_subscriber.dart';

import 'use_case_block_test.mocks.dart';

class TestState extends State {}
class TestIntent extends UseCaseIntent {}

class TestUseCaseBloc extends UseCaseBloc<TestState, TestIntent> {
  TestUseCaseBloc(super.initialState) {
    on<TestIntent>((event, emit) async {
        emit(TestState());
    }); 
  }
}

class TestSubscriber extends Mock implements UseCaseSubscriber {}

@GenerateMocks([TestSubscriber])
void main() {
  late TestUseCaseBloc useCase;
  late TestSubscriber subscriber;
  
  setUp(() {
    useCase = TestUseCaseBloc(TestState());
    subscriber = MockTestSubscriber();

    // Mock dependency injection
    final injector = Injector.appInstance;
    injector.clearAll();
    injector.registerDependency<String>(() { return "Mocked dependency"; });
  });

  test('Initial state is correct', () {
    expect(useCase.state, isA<TestState>());
  });

  blocTest<TestUseCaseBloc, TestState>(
    'Emits new state when intent is added',
    build: () => useCase,
    act: (bloc) => bloc.add(TestIntent()),
    expect: () => [isA<TestState>()],
  );

    test('get retrieves dependency from injector', () {
    final result = useCase.get<String>();
    expect(result, equals("Mocked dependency"));
  });


    test('subscribe adds a subscription', () {
    useCase.subscribe(subscriber, (state) {});
    expect(useCase.subscriptions.containsKey(subscriber), isTrue);
  });

  test('unsubscribe removes a subscription', () {
    useCase.subscribe(subscriber, (state) {});
    useCase.unsubscribe(subscriber);
    expect(useCase.subscriptions.containsKey(subscriber), isFalse);
  });

    test('unsubscribe does not throw if subscriber not found', () {

        // Attempt to unsubscribe before subscribing.
        // Previously threw an error because _subscriptions[subscriber] was null.
    expect(() => useCase.unsubscribe(subscriber), returnsNormally);
  });
}
