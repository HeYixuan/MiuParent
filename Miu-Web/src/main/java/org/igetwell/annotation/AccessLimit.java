package org.igetwell.annotation;


import java.lang.annotation.*;

@Inherited
@Documented
@Target({ElementType.FIELD,ElementType.TYPE,ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface AccessLimit {

    int limit() default 5;

    int sec() default 5;
}
