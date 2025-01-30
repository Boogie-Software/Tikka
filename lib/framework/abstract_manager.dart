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
import 'package:tikka/adapter/manager.dart';

/// Abstract class [AbstractManager] defines a base class for all concrete Manager
/// concrete implementations. Concrete implementations are placed to Framework layer. 
abstract class AbstractManager implements Manager {

    /// A utility method for simple dependency injection.
  T get<T>({String dependencyName = ""}) => Injector.appInstance.get<T>(dependencyName: dependencyName);
}