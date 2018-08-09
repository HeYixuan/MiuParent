package org.igetwell.system.limit.service.impl;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ThreadPoolService {

    ExecutorService exe = Executors.newCachedThreadPool();
}
