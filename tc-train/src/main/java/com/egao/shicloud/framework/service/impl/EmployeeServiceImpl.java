package com.egao.shicloud.framework.service.impl;

import com.egao.shicloud.framework.entity.Employee;
import com.egao.shicloud.framework.mapper.EmployeeMapper;
import com.egao.shicloud.framework.service.IEmployeeService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author tangxi
 * @since 2020-04-23
 */
@Service
public class EmployeeServiceImpl extends ServiceImpl<EmployeeMapper, Employee> implements IEmployeeService {

}
