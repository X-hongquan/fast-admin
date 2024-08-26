package com.chq.app.common.async;


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
                    throw new RuntimeException("服务异常");
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
