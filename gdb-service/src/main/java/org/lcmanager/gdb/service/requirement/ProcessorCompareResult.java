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
package org.lcmanager.gdb.service.requirement;

import org.lcmanager.gdb.base.MathUtil;
import org.lcmanager.gdb.service.compare.CompareResult;

import lombok.Builder;
import lombok.Data;

/**
 * Represents the result of a comparison executed by the
 * {@link ProcessorComparator}.
 *
 */
@Data
@Builder
public class ProcessorCompareResult implements CompareResult {
    /**
     * The score of the core count.
     * 
     */
    private final int coreScorePercentage;
    /**
     * The score of the frequency.
     * 
     */
    private final int frequencyScorePercentage;
    /**
     * The score of the instruction set.
     * 
     * <p>
     * NOTE: This is a KO-criteria!
     * </p>
     * 
     */
    private final int instructionSetScorePercentage;
    /**
     * The score of the threads.
     * 
     */
    private final int threadsScorePercentage;

    /**
     * {@inheritDoc}
     *
     * @see org.lcmanager.gdb.service.compare.CompareResult#getPercentage()
     */
    @Override
    public int getPercentage() {
        if (this.instructionSetScorePercentage == 0) {
            return 0;
        }

        return MathUtil.average(this.coreScorePercentage, this.frequencyScorePercentage, this.instructionSetScorePercentage,
                this.threadsScorePercentage);
    }
}
