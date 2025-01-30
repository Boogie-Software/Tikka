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

/// A utility class that can be used in implementing REST API responses.
sealed class RestResponse {}

/// [Success] is used to represent a successful response. It wraps the returned value.
class Success<T> extends RestResponse {

  final T data;

  Success(this.data);
}

/// [Failure] is used to represent a failed response. It wraps the error message.
class Failure extends RestResponse {

  final String errorMessage;

  Failure(this.errorMessage);
}