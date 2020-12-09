package org.giangnt.config;

import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.List;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@SuppressWarnings("deprecation")
@Configuration
@EnableWebMvc
public class WebMvcConfig extends WebMvcConfigurerAdapter {

    private static final Charset UTF8 = Charset.forName("UTF-8");

    // config utf-8 for view pages
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        StringHttpMessageConverter stringHttpMessageConverter = new StringHttpMessageConverter();
        stringHttpMessageConverter.setSupportedMediaTypes(Arrays.asList(new MediaType("text", "plain", UTF8)));
        converters.add(stringHttpMessageConverter);
    }

    //config to use html, img, css, ... file
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/assets/css/**").addResourceLocations("/WEB-INF/resources/assets/css/").setCachePeriod(31556926);
        registry.addResourceHandler("/assets/img/**").addResourceLocations("/WEB-INF/resources/assets/img/").setCachePeriod(31556926);
        registry.addResourceHandler("/assets/js/**").addResourceLocations("/WEB-INF/resources/assets/js/").setCachePeriod(31556926);
//        registry.addResourceHandler("/assets/ionicons-2.0.1/**").addResourceLocations("/WEB-INF/resources/assets/ionicons-2.0.1/").setCachePeriod(31556926);
        registry.addResourceHandler("/assets/fonts/**").addResourceLocations("/WEB-INF/resources/assets/fonts/").setCachePeriod(31556926);
        registry.addResourceHandler("/assets/scss/**").addResourceLocations("/WEB-INF/resources/assets/scss/").setCachePeriod(31556926);
        registry.addResourceHandler("/assets/vendor/**").addResourceLocations("/WEB-INF/resources/assets/vendor/").setCachePeriod(31556926);
    }

    //equivalent for <mvc:default-servlet-handler/> tag
    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }
}
