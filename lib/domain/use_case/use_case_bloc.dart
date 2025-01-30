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

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:tikka/domain/entity/state.dart';
import 'package:tikka/domain/use_case/use_case_intent.dart';
import 'package:tikka/domain/use_case/use_case_subscriber.dart';

/// [UseCaseBloc] provides an abstract base class for concrete [Bloc] implementations
/// that are used as use case or interactor components in Domain layer.
abstract class UseCaseBloc<S extends State, I extends UseCaseIntent> extends Bloc<I, S> {
  
  //StreamSubscription<S>? _subscription;
  final Map<UseCaseSubscriber, StreamSubscription<S>> subscriptions = {};

  /// Constructs a new instance of [UseCase] with the given [initialState].
  UseCaseBloc(super.initialState);

  /// A utility method for simple dependency injection.
  T get<T>({String dependencyName = ""}) => Injector.appInstance.get<T>(dependencyName: dependencyName);

  /// Subscribes the given [UseCaseSubscriber] to listen the streams of this [UseCaseBloc].
  /// 
  /// Returns a [StreamSubscription] which handles events from this stream using
  /// the provided [onData], [onError] and [onDone] handlers.
  /// The handlers can be changed on the subscription, but they start out
  /// as the provided functions.
  ///
  /// On each data event from this stream, the subscriber's [onData] handler
  /// is called. If [onData] is `null`, nothing happens.
  ///
  /// On errors from this stream, the [onError] handler is called with the
  /// error object and possibly a stack trace.
  ///
  /// The [onError] callback must be of type `void Function(Object error)` or
  /// `void Function(Object error, StackTrace)`.
  /// The function type determines whether [onError] is invoked with a stack
  /// trace argument.
  /// The stack trace argument may be [StackTrace.empty] if this stream received
  /// an error without a stack trace.
  ///
  /// Otherwise it is called with just the error object.
  /// If [onError] is omitted, any errors on this stream are considered unhandled,
  /// and will be passed to the current [Zone]'s error handler.
  /// By default unhandled async errors are treated
  /// as if they were uncaught top-level errors.
  ///
  /// If this stream closes and sends a done event, the [onDone] handler is
  /// called. If [onDone] is `null`, nothing happens.
  ///
  /// If [cancelOnError] is `true`, the subscription is automatically canceled
  /// when the first error event is delivered. The default is `false`.
  ///
  /// While a subscription is paused, or when it has been canceled,
  /// the subscription doesn't receive events and none of the
  /// event handler functions are called. 
  StreamSubscription<S> subscribe(UseCaseSubscriber subscriber, void Function(S event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
      final subscription = stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
      subscriptions[subscriber] = subscription;
      return subscription;
    }  

  /// Subscribes the given [UseCaseSubscriber] from listening the stream of data of this [UseCaseBloc]
  void unsubscribe(UseCaseSubscriber subscriber) {
    final subscription = subscriptions[subscriber];

    if (subscription != null) {
      subscription.cancel();
      subscriptions.remove(subscriber);
    }
  }    
}