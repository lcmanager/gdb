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
package org.lcmanager.gdb.config;

import java.util.Properties;

import org.springframework.cache.CacheManager;
import org.springframework.cache.support.NoOpCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import freemarker.cache.NullCacheStorage;
import lombok.val;

/**
 * Configures some things that only make sense during development (e.g. disable
 * caches).
 *
 */
@Configuration
@Profile("dev")
@PropertySource("classpath:application.dev.properties")
public class DevConfiguration {
    /**
     * Configures Freemarker not to cache the templates.
     *
     * @return The Freemarker configurer.
     */
    @Bean
    public FreeMarkerConfigurer freeMarkerConfigurer() {
        val freeMarkerConfigurer = new FreeMarkerConfigurer();
        final Properties settings = new Properties();
        settings.setProperty("cache_storage", NullCacheStorage.class.getName());
        freeMarkerConfigurer.setFreemarkerSettings(settings);
        freeMarkerConfigurer.setTemplateLoaderPaths("classpath:/templates");
        return freeMarkerConfigurer;
    }

    /**
     * Creates a non-caching {@link CacheManager}.
     *
     * @return The {@link CacheManager}.
     */
    @Bean
    public CacheManager cacheManager() {
        return new NoOpCacheManager();
    }
}
