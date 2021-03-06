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
package org.lcmanager.gdb.service.graphics.exception;

import org.lcmanager.gdb.service.exception.ServiceException;

/**
 * The base exception for all exceptions thrown by any graphics service.
 *
 */
public abstract class GraphicsServiceException extends ServiceException {
    /**
     * The serial version UID.
     *
     */
    private static final long serialVersionUID = 3194156926693190457L;

    /**
     * Constructor of GraphicsServiceException.
     *
     * @param message
     *            A detailed error message.
     * @param cause
     *            The causing error.
     */
    public GraphicsServiceException(final String message, final Throwable cause) {
        super(message, cause);
    }

    /**
     * Constructor of GraphicsServiceException.
     *
     * @param message
     *            A detailed error message.
     */
    public GraphicsServiceException(final String message) {
        super(message);
    }
}
