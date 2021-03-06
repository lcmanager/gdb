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
package org.lcmanager.gdb.service.data.model;

import java.util.Locale;

import lombok.Data;
import lombok.experimental.Accessors;

import org.lcmanager.gdb.base.Formatable;

/**
 * Represents a genre that can be assigned to a game (e.g. <code>Strategy</code>
 * ).
 *
 */
@Data
@Accessors(chain = true)
public class Genre implements BaseModel<Integer>, Formatable {
    /**
     * The serial version UID.
     *
     */
    private static final long serialVersionUID = 6694686278031486441L;

    // ~ Direct ~
    /**
     * The ID of this genre. Represents a steam genre ID.
     * 
     */
    private Integer id;
    /**
     * The description of this genre.
     * 
     */
    private String description;

    /**
     * {@inheritDoc}
     *
     * @see org.lcmanager.gdb.base.Formatable#format(java.util.Locale)
     */
    @Override
    public String format(final Locale locale) {
        return this.description;
    }
}
