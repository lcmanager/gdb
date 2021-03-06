/*
 * #%L
 * Game Database
 * %%
 * Copyright (C) 2016 - 2016 LCManager Group
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
package org.lcmanager.gdb.web.control.rest;

import java.util.Map;

import lombok.Value;

import org.lcmanager.gdb.service.data.model.User;
import org.lcmanager.gdb.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Handles the REST authentication that is also used by the login page to
 * auto-login.
 *
 */
@RestController
@RequestMapping("/auth")
public class AuthenticationController {
    /**
     * The {@link UserService}.
     * 
     */
    @Autowired
    private UserService userService;

    /**
     * Creates an authentication status that represents the current
     * authentication state.
     *
     * @return The authentication status.
     */
    @RequestMapping
    public AuthenticationStatus loginStatus() {
        final User user = this.userService.retrieveUser();
        if (user == null) {
            return AuthenticationStatus.NOT_AUTHENTICATED;
        }
        return new AuthenticationStatus(true, user);
    }

    /**
     * Logs the user in.
     * 
     * @param checkOnly
     *            A query parameter whether the really login (<code>false</code>
     *            ) or just to check whether the credentials are correct (
     *            <code>true</code>).
     * @param body
     *            The body of the request. Must contain a property
     *            <code>username</code> and a property <code>password</code>.
     * @return The new authentication status.
     */
    @RequestMapping(method = RequestMethod.POST)
    public AuthenticationStatus login(@RequestParam(defaultValue = "true") final boolean checkOnly,
            @RequestBody final Map<String, String> body) {
        final String username = body.get("username");
        final String password = body.get("password");
        final User user = this.userService.authenticate(username, password, checkOnly);
        final AuthenticationStatus result;
        if (user == null) {
            result = AuthenticationStatus.NOT_AUTHENTICATED;
        } else {
            result = new AuthenticationStatus(true, user);
        }
        return result;
    }

    /**
     * An immutable class representing an authentication status.
     *
     */
    @Value
    public static class AuthenticationStatus {
        /**
         * An authentication status of a non-authenticated user.
         * 
         */
        public static final AuthenticationStatus NOT_AUTHENTICATED = new AuthenticationStatus(false, null);

        /**
         * Whether the user is authenticated or not-
         * 
         */
        boolean authenticated;
        /**
         * The user details of the user, if any.
         * 
         */
        UserDetails userDetails;
    }
}
