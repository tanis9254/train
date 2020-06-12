package ${project.basePackage}.business.${domain.name?uncap_first}.controller;

import com.rsy.rxf.springmvc.PageRequest;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.rsy.rxf.springmvc.RestConstant;
import com.rsy.rxf.springmvc.exception.BusinessException;
import com.rsy.rxf.springmvc.ResultModel;
import ${project.basePackage}.business.${model.domain.name?uncap_first}.service.${model.name?cap_first}Service;
import ${project.basePackage}.po.business.${model.domain.name?uncap_first}.${model.name?cap_first};
import ${project.basePackage}.vo.business.${model.domain.name?uncap_first}.${model.name?cap_first}VO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
<#list model.attribute as pro>
    <#if pro.type == 'Reference' >
import ${project.basePackage}.po.business.${pro.reference.domain.name?uncap_first}.${pro.reference.name?cap_first};
import ${project.basePackage}.business.${pro.reference.domain.name?uncap_first}.service.${pro.reference.name?cap_first}Service;
    <#elseif pro.type == 'Files' >
import ${project.basePackage}.business.system.domain.Attachment;
import ${project.basePackage}.business.system.service.AttachmentService;
    </#if>
</#list>
<#list model.attribute as pro>
    <#if pro.type == 'SimpleConfig' >
import com.rsy.rxf.po.admin.dict.DictionaryItem;
import ${project.basePackage}.admin.dict.service.DictionaryItemService;
        <#break>
    </#if>
</#list>

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import com.baomidou.mybatisplus.plugins.Page;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.BeanUtils;

/**
 * 管理${model.displayName}
 *
 * Created by Recloud
 */
@RestController
@RequestMapping(value = "/business/${model.domain.name?uncap_first}/${model.name?uncap_first}")
@Api(value = "管理${model.displayName}", description = "${model.displayName}服务接口")
public class ${model.name?cap_first}Controller {

	private static final Logger LOGGER = LoggerFactory.getLogger(${model.name?cap_first}Controller.class);

<#list model.attribute as pro>
    <#if pro.type == 'SimpleConfig' >
	@Autowired
	private DictionaryItemService dictionaryItemService;
        <#break>
    </#if>
</#list>

	@Autowired
	private ${model.name?cap_first}Service ${model.name?uncap_first}Service;
<#list model.attribute as pro>
    <#if pro.type == 'Reference' >

	@Autowired
	private ${pro.reference.name?cap_first}Service ${pro.reference.name?uncap_first}Service;
    <#elseif pro.type == 'Files' >

	@Autowired
	private AttachmentService attachmentService;
    </#if>
</#list>

	/**
	 * 新增${model.displayName}
     *
	 * @param ${model.name?uncap_first}VO
	 * @return
	 */
	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
    @ApiOperation(value = "新增${model.displayName}", produces = "application/json")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "header", dataType = "String", name = "Authorization", value = "oauth2 Token", required = true, defaultValue = "bearer xxxxxxxxxxx"),
            @ApiImplicitParam(paramType = "body", dataType = "${model.name?cap_first}VO", name = "${model.name?uncap_first}VO", value = "${model.displayName}对象", required = true)
    })
	public ResultModel create(@RequestBody @Valid ${model.name?cap_first}VO ${model.name?uncap_first}VO){
        try {
            ${model.name?cap_first} ${model.name?uncap_first} = new ${model.name?cap_first}();
            BeanUtils.copyProperties(${model.name?uncap_first}VO, ${model.name?uncap_first});
            if (${model.name?uncap_first}Service.insert(${model.name?uncap_first})) {
                return ResultModel.createSuccess();
            }
        } catch (BusinessException be) {
            LOGGER.error(be.getMessage(), be);
            return ResultModel.failure(be.getCode(), be.getMessage());
        } catch (Exception e) {
            LOGGER.error(RestConstant.CREATE_MSG_FAILURE, e);
        }
        return ResultModel.createFailure();
	}

	/**
     * 删除${model.displayName},id以逗号分隔
     *
     * @param idArray
     */
	@DeleteMapping(value="/{idArray}")
    @ApiOperation(value = "删除${model.displayName}", notes = "根据url的${model.displayName}id来指定删除对象，多个id以逗号分隔")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "header", dataType = "String", name = "Authorization", value = "oauth2 Token", required = true, defaultValue = "bearer xxxxxxxxxxx"),
            @ApiImplicitParam(paramType = "path", dataType = "String", name = "idArray", value = "${model.displayName}id来指定删除对象，多个id以逗号分隔", required = true)
    })
	public ResultModel delete(@PathVariable String idArray){
        try {
            String[] ids = idArray.split(",");
            List<Long> idList = new ArrayList<>();
            for (String idStr : ids) {
                idList.add(Long.valueOf(idStr));
            }
            if (${model.name?uncap_first}Service.deleteBatchIds(idList)) {
                return ResultModel.deleteSuccess();
            }
        }  catch (BusinessException be) {
            LOGGER.error(be.getMessage(), be);
            return ResultModel.failure(be.getCode(), be.getMessage());
        } catch (Exception e) {
            LOGGER.error(RestConstant.DELETE_MSG_FAILURE, e);
        }
        return ResultModel.deleteFailure();
    }

    /**
     * 更新${model.displayName}
     *
     * @param ${model.name?uncap_first}VO
     * @param id
     * @return
     */
    @PutMapping(value="/{id}")
    @ApiOperation(value = "更新${model.displayName}", produces = "application/json")
    @ApiImplicitParams({
    @ApiImplicitParam(paramType = "header", dataType = "String", name = "Authorization", value = "oauth2 Token", required = true, defaultValue = "bearer xxxxxxxxxxx"),
    @ApiImplicitParam(paramType = "body", dataType = "${model.name?cap_first}VO", name = "${model.name?uncap_first}VO", value = "${model.displayName}对象", required = true),
    @ApiImplicitParam(paramType = "path", dataType = "Long", name = "id", value = "${model.displayName}对象的ID", required = true)
    })
    public ResultModel update(@RequestBody @Valid ${model.name?cap_first}VO ${model.name?uncap_first}VO, @PathVariable Long id){
        try {
            ${model.name?uncap_first}VO.setId(id);
            ${model.name?cap_first} ${model.name?uncap_first} = new ${model.name?cap_first}();
            BeanUtils.copyProperties(${model.name?uncap_first}VO, ${model.name?uncap_first});

            if (${model.name?uncap_first}Service.updateById(${model.name?uncap_first})) {
                return ResultModel.updateSuccess();
            }
        } catch (BusinessException be) {
            LOGGER.error(be.getMessage(), be);
            return ResultModel.failure(be.getCode(), be.getMessage());
        } catch (Exception e) {
            LOGGER.error(RestConstant.UPDATE_MSG_FAILURE, e);
        }
        return ResultModel.updateFailure();
    }



    /**
     * 分页查询${model.displayName}列表
     *
     * @param params
     * @return
     */
    @GetMapping("/list")
    @ApiOperation(value = "分页查询${model.displayName}列表")
    @ApiImplicitParams({
    @ApiImplicitParam(paramType = "header", dataType = "String", name = "Authorization", value = "oauth2 Token", required = true, defaultValue = "bearer xxxxxxxxxxx"),
    @ApiImplicitParam(paramType = "query", dataType = "String", name = "params", value = "table分页请求参数", required = true, defaultValue = "{\"page\":1,\"limit\":10,\"searchCondition\":{}")
    })
    public ResultModel list(String params){
        try {
            PageRequest<${model.name?cap_first}VO> pageRequest = JSON.parseObject(params, new TypeReference<PageRequest<${model.name?cap_first}VO>>(){});
            Page<${model.name?cap_first}> ${model.name?uncap_first}Page =  ${model.name?uncap_first}Service.findPage(new Page<>(pageRequest.getPage(), pageRequest.getLimit()), pageRequest.getSearchCondition());
            List<${model.name?cap_first}> ${model.name?uncap_first}List = ${model.name?uncap_first}Page.getRecords();
            List<${model.name?cap_first}VO> ${model.name?uncap_first}VOList = new ArrayList<>();
            ${model.name?cap_first}VO ${model.name?uncap_first}VO;
            for (${model.name?cap_first} ${model.name?uncap_first} : ${model.name?uncap_first}List) {
                ${model.name?uncap_first}VO = new ${model.name?cap_first}VO();
                BeanUtils.copyProperties(${model.name?uncap_first}, ${model.name?uncap_first}VO);
                initViewProperty(${model.name?uncap_first}VO);
                ${model.name?uncap_first}VOList.add(${model.name?uncap_first}VO);
            }
            return ResultModel.selectPaginationSuccess(${model.name?uncap_first}Page, ${model.name?uncap_first}VOList);
        } catch (BusinessException be) {
            LOGGER.error(be.getMessage(), be);
            return ResultModel.failure(be.getCode(), be.getMessage());
        } catch (Exception e) {
            LOGGER.error(RestConstant.SELECT_MSG_FAILURE, e);
        }
        return ResultModel.selectFailure();
    }


    /**
     * 根据ID查询${model.displayName}
     *
     * @param id
     * @return
     */
    @GetMapping(value="/{id}")
    @ApiOperation(value = "查询${model.displayName}", notes = "根据url的id来查询${model.displayName}")
    @ApiImplicitParams({
        @ApiImplicitParam(paramType = "header", dataType = "String", name = "Authorization", value = "oauth2 Token", required = true, defaultValue = "bearer xxxxxxxxxxx"),
        @ApiImplicitParam(paramType = "path", dataType = "Long", name = "id", value = "${model.displayName}id", required = true)
    })
    public ResultModel get(@PathVariable Long id) {
        try {
            ${model.name?cap_first} ${model.name?uncap_first} = ${model.name?uncap_first}Service.selectById(id);
            ${model.name?cap_first}VO ${model.name?uncap_first}VO = new ${model.name?cap_first}VO();
            BeanUtils.copyProperties(${model.name?uncap_first},${model.name?uncap_first}VO);
            return ResultModel.selectSuccess(${model.name?uncap_first}VO);
        } catch (BusinessException be) {
            LOGGER.error(be.getMessage(), be);
            return ResultModel.failure(be.getCode(), be.getMessage());
        } catch (Exception e) {
            LOGGER.error(RestConstant.SELECT_MSG_FAILURE, e);
        }
        return ResultModel.selectFailure();
    }

    /**
     * 查询${model.displayName}列表
     *
     * @return
     */
    @GetMapping("/listAll")
    @ApiOperation(value = "所有${model.displayName}列表")
    public ResultModel listAll(){
        try {
            List<${model.name?cap_first}VO> ${model.name?uncap_first}VOList = new ArrayList<>();
            EntityWrapper<${model.name?cap_first}> entityWrapper = new EntityWrapper<>();
            List<${model.name?cap_first}> ${model.name?uncap_first}List = ${model.name?uncap_first}Service.selectList(entityWrapper);
            ${model.name?cap_first}VO ${model.name?uncap_first}VO;
            for (${model.name?cap_first} ${model.name?uncap_first} : ${model.name?uncap_first}List) {
                ${model.name?uncap_first}VO = new ${model.name?cap_first}VO();
                BeanUtils.copyProperties(${model.name?uncap_first},${model.name?uncap_first}VO);
                ${model.name?uncap_first}VOList.add(${model.name?uncap_first}VO);
            }
            return ResultModel.selectSuccess(${model.name?uncap_first}VOList);
        } catch (BusinessException be) {
            LOGGER.error(be.getMessage(), be);
            return ResultModel.failure(be.getCode(), be.getMessage());
        }  catch (Exception e) {
            LOGGER.error(RestConstant.SELECT_MSG_FAILURE, e);
        }
        return ResultModel.selectFailure();
    }

    /**
     * 初始化其他对象
     *
     * @param ${model.name?uncap_first}VO
     * @return
     */
    private void initViewProperty(${model.name?cap_first}VO ${model.name?uncap_first}VO){
	<#list model.attribute as pro>
    <#if pro.type == 'Reference' >
        ${pro.reference.name?cap_first} ${pro.name?uncap_first} = ${pro.reference.name?uncap_first}Service.selectById(${model.name?uncap_first}VO.get${pro.name?cap_first}Id());
	    if(${pro.name?uncap_first}!=null) {
            ${model.name?uncap_first}VO.set${pro.name?cap_first}Name(${pro.name?uncap_first}.getName());
	    }
    <#elseif pro.type == 'SimpleConfig' >
        DictionaryItem ${pro.name?uncap_first}DictionaryItem = new DictionaryItem();
        ${pro.name?uncap_first}DictionaryItem.setCode(${model.name?uncap_first}VO.get${pro.name?cap_first}Code());
        ${pro.name?uncap_first}DictionaryItem.setTypeCode("${improvedNamingStrategy(model.name)?upper_case}_${improvedNamingStrategy(pro.name)?upper_case}");
        DictionaryItem ${pro.name?uncap_first}ResultDict = dictionaryItemService.selectOne(new EntityWrapper<>(${pro.name?uncap_first}DictionaryItem));
        if(${pro.name?uncap_first}ResultDict!=null) {
            ${model.name?uncap_first}VO.set${pro.name?cap_first}Name(${pro.name?uncap_first}ResultDict.getName());
        }
    </#if>
    </#list>
    }
}
