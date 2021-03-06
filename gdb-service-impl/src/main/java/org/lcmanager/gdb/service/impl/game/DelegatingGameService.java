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
package org.lcmanager.gdb.service.impl.game;

import org.lcmanager.gdb.base.Paged;
import org.lcmanager.gdb.service.annotation.Branded;
import org.lcmanager.gdb.service.annotation.Generic;
import org.lcmanager.gdb.service.data.model.Game;
import org.lcmanager.gdb.service.game.GameQuery;
import org.lcmanager.gdb.service.game.GameService;
import org.lcmanager.gdb.service.game.exception.GameServiceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

/**
 * Generic implementation of {@link GameService} that just delegates to other
 * {@link GameService game services} (both generic and branded ones).
 *
 */
@Service
@Primary
@CacheConfig(cacheNames = "delegating-game-service")
public class DelegatingGameService implements GameService {
    /**
     * The generic {@link DatabaseGameService}.
     * 
     */
    @Autowired
    @Qualifier("dbGameService")
    @Generic
    private GameService dbGameService;
    /**
     * The branded {@link GameService}.
     * 
     */
    @Autowired
    @Branded
    private GameService brandedGameService;

    /**
     * {@inheritDoc}
     *
     * @see org.lcmanager.gdb.service.game.GameService#retrieveGames(org.lcmanager.gdb.service.game.GameQuery,
     *      int, boolean)
     */
    @Override
    @Cacheable
    public Paged<Game> retrieveGames(final GameQuery query, final int page, final boolean loadAll) throws GameServiceException {
        return this.brandedGameService.retrieveGames(query, page, loadAll);
    }

    /**
     * {@inheritDoc}
     *
     * @see org.lcmanager.gdb.service.game.GameService#retrieveGame(int)
     */
    @Override
    @Cacheable
    public Game retrieveGame(final int gameId) throws GameServiceException {
        Game game = this.dbGameService.retrieveGame(gameId);
        if (game == null) {
            game = this.brandedGameService.retrieveGame(gameId);
            this.dbGameService.save(game);
        }
        return game;
    }
}
