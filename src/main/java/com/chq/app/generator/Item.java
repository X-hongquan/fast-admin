package com.chq.app.generator;


public interface Item {

   void buildBody(Class<?> clazz);

   String render(String s);
}
