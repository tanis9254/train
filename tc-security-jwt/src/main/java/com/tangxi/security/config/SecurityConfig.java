package com.tangxi.security.config;

import com.tangxi.security.config.filters.JwtAuthenticationTokenFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author: tang.xi
 * @date: 2020/5/9
 * @description:
 */
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private JwtUserDetailService jwtUserDetailService;

    @Autowired
    private JwtAuthenticationTokenFilter jwtAuthenticationTokenFilter;

    @Autowired
    private RestAuthenticationEntryPoint restAuthenticationEntryPoint;

    @Autowired
    private RestfulAccessDeniedHandler restfulAccessDeniedHandler;

    private String[] blankUrlArray = null;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(jwtUserDetailService).passwordEncoder(new BCryptPasswordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        initBlankUrlList();
        // 去掉 CSRF
        http.csrf().disable()
                // 使用 JWT，关闭session
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                //定义哪些URL需要被保护、哪些不需要被保护
                .authorizeRequests()
                .antMatchers(blankUrlArray).permitAll()
                .antMatchers(HttpMethod.OPTIONS)//跨域请求会先进行一次options请求
                .permitAll()
                //任何请求,登录后可以访问
                .anyRequest().authenticated();

        // 禁用缓存
        http.headers().cacheControl();
        // 关闭frameOption
        http.headers().frameOptions().disable();
        // 添加JWT filter
        http.addFilterBefore(jwtAuthenticationTokenFilter, UsernamePasswordAuthenticationFilter.class);
        //添加自定义未授权和未登录结果返回
        http.exceptionHandling()
                .accessDeniedHandler(restfulAccessDeniedHandler)
                .authenticationEntryPoint(restAuthenticationEntryPoint);
    }

    private void initBlankUrlList() {
        if (blankUrlArray != null && blankUrlArray.length > 0) {
            return;
        }
        List<String> blankUrlList = new ArrayList<>();
        // 登录相关接口
        blankUrlList.add("/**/login/**");
        /*
            swagger start
          */
        // swagger页面展示
        blankUrlList.add("/swagger-ui.html");
        // swagger提供的服务
        blankUrlList.add("/swagger-resources/**");
        // swagger基础api服务
        blankUrlList.add("/v2/api-docs");
        // swagger展示页面需要的服务
        blankUrlList.add("/webjars/**");
        /*
            swagger end
         */
        blankUrlList.addAll(Arrays.asList("/**/*.html", "/**/js/**", "/**/css/**", "/**/img/**", "/**/images/**"));
        // esi接口不需要token
        blankUrlList.add("/esi/**");
        blankUrlList.add("/v2/**");
        blankUrlList.add("/business/hsp/rule/excel/**");
        // socket相关服务不需要验证
        blankUrlList.add("/socket/**");
        //处方笺展示
        blankUrlList.add("/business/salesman/prescriptionPick/Prescription");
        //支付成功的回调服务
        blankUrlList.add("/business/payNotify/saasPayNotify");
        //下载服务
        blankUrlList.add("/file/download");
        //处方自动审核
        blankUrlList.add("/business/ppt/prescription/footprint/prescription/auto/review");
        //显示所有的附件上传链接"
        blankUrlList.add("/management/upload/url/list");

        blankUrlList.add("/business/chat/OnlineInformat/**");

        /*// 添加自定义白名单
        if (businessBlank.length() > 0) {
            blankUrlList.addAll(Arrays.asList(businessBlank.split(",")));
        }*/
        blankUrlArray = new String[blankUrlList.size()];
        blankUrlArray = blankUrlList.toArray(blankUrlArray);
    }
}
