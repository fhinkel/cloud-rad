/*
  Copyright 2023 Google LLC

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

import * as v1 from './v1';
import * as v1alpha1 from './v1alpha1';
import * as v1alpha2 from './v1alpha2';
import * as v1beta from './v1beta';
import * as v2 from './v2';
declare const FooClient: typeof v2.FooClient;
type FooClient = v2.FooClient;
export { v1, v1alpha1, v1alpha2, v1beta, v2, FooClient };
declare const _default: {
  v1: typeof v1;
  v1alpha1: typeof v1alpha1;
  v1alpha2: typeof v1alpha2;
  v1beta: typeof v1beta;
  v2: typeof v2;
  FooClient: typeof v2.FooClient;
};
export default _default;
import * as protos from '../protos/protos';
export { protos };