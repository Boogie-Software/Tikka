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

/// A utility class that defines a set of predefined [SizedBox] widgets.
class Spacings {
  static const spacing8 = SizedBox(width: 8, height: 8);
  static const spacing16 = SizedBox(width: 16, height: 16);
  static const spacing32 = SizedBox(width: 32, height: 32);
  static const spacing64 = SizedBox(width: 64, height: 64);
  static const spacing72 = SizedBox(width: 72, height: 72);
  static const spacing80 = SizedBox(width: 80, height: 80);

  static SizedBox spacing(double size) => SizedBox(width: size, height: size);
}