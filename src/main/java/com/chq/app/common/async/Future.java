package com.chq.app.common.async;


import com.chq.app.common.exception.ServiceException;

public class Future {

    private Object response;

    /**
     * 只有两个主线程，和异步线程不存在虚假唤醒
     *
     * @param timeout
     * @return
     */
    public <T> T get(long timeout) {
        synchronized (this) {
            while (response == null) {
                try {
                    this.wait(timeout);
                } catch (InterruptedException e) {
                    throw new ServiceException("异步线程执行超时");
                }
            }
        }
        return (T) response;
    }

    public <T> T get() {
        return get(0L);
    }


    public void complete(Object response) {
        synchronized (this) {
            this.response = response;
            this.notifyAll();
        }
    }
}
