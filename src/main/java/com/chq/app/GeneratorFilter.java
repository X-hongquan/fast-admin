package com.chq.app;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

public interface GeneratorFilter {

    boolean filterField(Field field);

    boolean filterClassByClass(Class<?> clazz);

    boolean filterClassByClassName(String className);

    boolean filterPackage(String directoryName);

    boolean filterMethod(Method method);
}
