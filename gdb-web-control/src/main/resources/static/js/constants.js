/*
 * #%L
 * Game Database Control
 * %%
 * Copyright (C) 2016 LCManager Group
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * #L%
 */

if (!('Constants' in window)) {
	window.Constants = {};
}

if (!('ContentType' in Constants)) {
	Constants.ContentType = {};
}
Constants.ContentType.FORM = 'application/x-www-form-urlencoded';

if (!('State' in Constants)) {
	Constants.State = {};
}
Constants.State.NOTHING = 'state_nothing';
Constants.State.LOADING = 'state_loading';
Constants.State.LOADED = 'state_loaded';
