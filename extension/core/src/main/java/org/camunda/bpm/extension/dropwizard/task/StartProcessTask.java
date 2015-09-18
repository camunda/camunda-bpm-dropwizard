/*
 *  Copyright 2013, 2014, 2015 Jan Galinski
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 *  27th May 2015 Modified by Chris Pheby
 */
package org.camunda.bpm.extension.dropwizard.task;

import com.google.common.collect.ImmutableMultimap;
import io.dropwizard.servlets.tasks.Task;
import org.camunda.bpm.engine.ProcessEngines;
import org.camunda.bpm.engine.runtime.ProcessInstance;

import java.io.PrintWriter;

public class StartProcessTask extends Task {

    private final String processKey;
    private ProcessInstance instance;

    public StartProcessTask(String processKey) {
        super("process/" + processKey);
        this.processKey = processKey;
    }

    @Override
    public void execute(ImmutableMultimap<String, String> immutableMultimap, final PrintWriter out) throws Exception {
        if ("true".equals(immutableMultimap.get("shutdown"))) {
            stopProcess();
            out.println("Process Stopped: " + processKey);
        } else {
            startProcess();
            out.println("Process Started: " + processKey);
        }
    }

    public ProcessInstance startProcess() {

        if (instance != null) {
            if (!instance.isEnded()) {
                return instance;
            }
        }
        instance = ProcessEngines.getDefaultProcessEngine().getRuntimeService().startProcessInstanceByKey(processKey);
        return instance;
    }

    public String stopProcess() {

        String instanceId = instance.getProcessInstanceId();
        ProcessEngines.getDefaultProcessEngine().getRuntimeService().deleteProcessInstance(instanceId, "DropWizard Administrative Request");
        return instanceId;
    }
}
