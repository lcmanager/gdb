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
package org.lcmanager.gdb.service.impl.data.mapper;

import org.apache.ibatis.annotations.Param;
import org.lcmanager.gdb.service.data.model.Category;

/**
 * Mapper for {@link Category}.
 *
 */
public interface CategoryMapper extends BaseMapper<Category, Integer> {
    /**
     * Checks whether any category with the given description exist.
     *
     * @param description
     *            The description to check.
     * @return Whether any category with the given description exists or not.
     */
    boolean existsDescription(@Param("description") String description);

    /**
     * Finds the category with the given description.
     *
     * @param description
     *            The description of the category to find.
     * @return The found category, if any.
     */
    Category findByDescription(@Param("description") String description);
}
