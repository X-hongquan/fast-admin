package com.chq.app;

import javax.annotation.Nullable;

public interface Item {

   void buildBody(Class<?> clazz);

   String render(@Nullable String s);
}
