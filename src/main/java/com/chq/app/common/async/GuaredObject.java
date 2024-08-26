package com.chq.app.common.async;

import lombok.Data;


public class GuaredObject<T> {

    private T response;

    /**
     * 只有两个主线程，和异步线程不存在虚假唤醒
     * @param timeout
     * @return
     */
    public T get(long timeout) {
        synchronized (this) {
            while (response == null) {
                try {
                    this.wait(timeout);
                } catch (InterruptedException e) {
                    throw new RuntimeException("服务异常");
                }
            }
        }
        return response;
    }

    public void set(T response) {
        synchronized (this) {
            this.response = response;
            this.notifyAll();
        }
    }
}
