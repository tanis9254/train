package com.tangxi.security.config;

import lombok.Data;
import lombok.ToString;
import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Set;

/**
 * Created by fai.yao on 2017/1/10.
 */
@Data
@ToString
public class SecurityUser<T> implements UserDetails {
    private static final long serialVersionUID = 1113799434508676095L;

    private T account;
    private String id;
    private String password;
    private String userName;

    private Set<GrantedAuthority> grantedAuthoritySet;

    public SecurityUser(String id, String userName, String password, T account, Set<GrantedAuthority> grantedAuthoritySet) {
        this.id = id;
        this.account = account;
        this.grantedAuthoritySet = grantedAuthoritySet;
        this.userName = userName;
        this.password = password;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return grantedAuthoritySet;
    }

    @Override
    public String getPassword() {
        return this.password;
    }

    @Override
    public String getUsername() {
        return this.userName;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

}
