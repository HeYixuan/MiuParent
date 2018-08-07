package org.igetwell.interceptor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

@Configuration
public class MyWebConfig extends WebMvcConfigurationSupport {


    @Bean
    public AccessLimitInterceptor getAccessLimitInterceptor(){
        return new AccessLimitInterceptor();
    }

    @Override
    protected void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(getAccessLimitInterceptor()).addPathPatterns("/**");
        super.addInterceptors(registry);
    }
}
