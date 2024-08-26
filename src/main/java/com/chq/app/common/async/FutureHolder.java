package com.chq.app.common.async;

public class FutureHolder {
    private static final ThreadLocal<Future> threadLocal = new ThreadLocal<>();

    public static void set(Future future) {
        threadLocal.set(future);
    }

    public static Future get() {
        Future future = threadLocal.get();
        if (future == null)
            System.out.println("threadLocal is null");
        return future;
    }


    public static void remove() {
        threadLocal.remove();
    }
}
