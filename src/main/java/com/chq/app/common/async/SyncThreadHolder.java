package com.chq.app.common.async;

import org.apache.poi.ss.formula.functions.T;

public class SyncThreadHolder {
    private static final ThreadLocal<GuaredObject> threadLocal = new ThreadLocal<>();

    public static void set(GuaredObject guaredObject) {
        threadLocal.set(guaredObject);
    }

    public static GuaredObject get() {
        return threadLocal.get();
    }


    public static void remove() {
        threadLocal.remove();
    }
}
