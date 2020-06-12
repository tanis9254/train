<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>处方外流平台</title>
    <link href="favicon.ico" rel="shortcut icon">
    <link href="/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/css/plugins/jsTree/style.min.css" rel="stylesheet">
    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css?v=4.1.0" rel="stylesheet">
    <link href="/css/plugins/bootstrap-table/bootstrap-table.css" rel="stylesheet">
    <link href="/css/plugins/treegrid/jquery.treegrid.css" rel="stylesheet">
    <link href="/css/plugins/toastr/toastr.min.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="/css/plugins/jquery-ztree/3.5/css/metro/zTreeStyle.css" type="text/css"rel="stylesheet">
    <link href="/css/plugins/datapicker/datepicker3.css" rel="stylesheet">
    <link href="/css/plugins/select2/select2.css" rel="stylesheet"/>
    <style>
        .datepicker {
            z-index: 16000 !important;
        }
        .bootstrap-datetimepicker-widget {
            z-index: 16001 !important;
        }
        .select2-container {
            z-index: 16000 !important;
        }
        .search-panel .dropdown-menu {
            padding: 15px;
            width: 600px;
        }
        .search-panel .form-group {
            margin-bottom: 8px;
        }
        .search-panel .dropdown-menu .search-form-label {
            width: 90px;
            float: left;
            line-height: 34px;
            margin-bottom: 0;
        }
        .search-panel .dropdown-menu .input {
            width: 180px;
            float: left;
        }
        .search-panel .dropdown-menu .line-input {
            width: 480px;
        }
        .search-panel .buttons {
            text-align: right;
            margin: 5px 0 0;
        }
        .search-panel .buttons .btn {
            margin: 0 0 0 5px;
        }
    </style>
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
        <div class="clearfix ibox-title">
            <div class="pull-left">
                <button id="${model.name?uncap_first}_btn_create" type="button" class="btn btn-outline btn-primary"><i
                        class="fa fa-plus"></i> 新增
                </button>
                <button id="${model.name?uncap_first}_btn_update" type="button" class="btn btn-outline btn-primary"><i
                        class="fa fa-pencil"></i> 修改
                </button>
                <button id="${model.name?uncap_first}_btn_delete" type="button" class="btn btn-outline btn-danger"><i
                        class="fa fa-remove"></i> 删除
                </button>
                <button id="${model.name?uncap_first}_btn_search" type="button" class="btn btn-outline btn-info"><i class="fa fa-filter"></i> 查询
                </button>
                <button id="${model.name?uncap_first}_btn_refresh" type="button" class="btn btn-outline btn-info"><i class="fa fa-refresh"></i> 刷新
                </button>
            </div>
            <div class="search-panel pull-right">
                <div class="input-group pull-left" style="width: 220px; margin-right: 5px;">
                    <input placeholder="名称" id="name_search" type="text" class="form-control">
                    <span class="input-group-btn">
                        <button type="button" class="btn btn-info">查询</button>
                    </span>
                </div>
                <div class="btn-group pull-right">
                    <button class="btn btn-success dropdown-toggle" type="button">
                        更多查询 <span class="caret"></span>
                    </button>
                    <div class="dropdown-menu">
                        <div class="row">
                            <#assign x=0 />
                            <#list model.attribute as pro>
                            <#if pro.inSearch || pro_index == 0>
                            <#if pro.type == 'DateTime' || pro.type == 'Date'>
                            <div class="col-sm-12 form-group">
                                <label>${pro.displayName}:
                                    <small class="text-success"></small>
                                </label>
                                <div class="input-daterange input-group" id="datepicker">
                                    <input type="text" class="form-control" id="${model.name?uncap_first}_${pro.name}_start_search" value="">
                                    <span class="input-group-addon">到</span>
                                    <input type="text" class="form-control" id="${model.name?uncap_first}_${pro.name}_end_search" value="">
                                </div>
                            </div>
                            <#elseif pro.type == 'Boolean'>
                            <div class="col-sm-6 form-group">
                                <label for="${model.name?uncap_first}_${pro.name}_search">${pro.displayName}:
                                    <small class="text-success"></small>
                                </label>
                                <select class="form-control" id="${model.name?uncap_first}_${pro.name}_search">
                                    <option value="">全部</option>
                                    <option value="1">启用</option>
                                    <option value="0">禁用</option>
                                </select>
                            </div>
                            <#elseif pro.type == 'Reference'  >
                            <div class="col-sm-6 form-group">
                                <label for="${model.name?uncap_first}_${pro.name}_id_search">${pro.displayName}:
                                    <small class="text-success"></small>
                                </label>
                                <select id="${model.name?uncap_first}_${pro.name}_id_search" name="${model.name?uncap_first}_${pro.name}_id_search" class="form-control">
                                </select>
                            </div>
                            <#elseif pro.type == 'SimpleConfig' >
                            <div class="col-sm-6 form-group">
                                <label for="${model.name?uncap_first}_${pro.name}_code_search">${pro.displayName}:
                                    <small class="text-success"></small>
                                </label>
                                <select id="${model.name?uncap_first}_${pro.name}_code_search" name="${model.name?uncap_first}_${pro.name}_code_search" class="form-control">
                                </select>
                            </div>
                            <#else >
                            <div class="col-sm-6 form-group">
                                <label for="${model.name?uncap_first}_${pro.name}_search">${pro.displayName}:
                                    <small class="text-success"></small>
                                </label>
                                <input type="text" class="form-control" id="${model.name?uncap_first}_${pro.name}_search">
                            </div>
                            </#if>
                            <#assign x=x+1 />
                            <#if x%3==0>
                            </#if>
                            </#if>
                            </#list>
                            <div class="col-sm-12 buttons">
                                <button id="${model.name?uncap_first}_reset" type="button" class="btn btn-outline btn-default"><i class="fa fa-refresh"></i>重置</button>
                                <button id="${model.name?uncap_first}_search" type="button" class="btn btn-outline btn-info"><i class="fa fa-search"></i>查询</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ibox-content">
            <table id="${model.name?uncap_first}_table" data-mobile-responsive="true">
            </table>
        </div>
    </div>
</div>

<!-- 创建 -->
<div class="modal inmodal" id="modal_form_create_${model.name?uncap_first}" tabindex="-1" role="dialog"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated bounceInRight">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title">新增${model.displayName}</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                <#list model.attribute as pro>
                    <div class="form-group">
                        <#if pro.type == 'DateTime' || pro.type=='Date'>
                            <label class="col-sm-3 control-label" for="create_${model.name?uncap_first}_${pro.name}"><#if pro.required == true><span class="red">*</span></#if>${pro.displayName}:</label>
                            <div class="col-sm-9 controls">
                                <div class="input-group date">
                                    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    <input type="text" class="form-control" id="create_${model.name?uncap_first}_${pro.name}" name="create_${model.name?uncap_first}_${pro.name}">
                                </div>
                            </div>
                        <#elseif pro.type=='Boolean'>
                        <label class="col-sm-3 control-label" for="create_${model.name?uncap_first}_${pro.name}"><#if pro.required == true><span class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <select id="create_${model.name?uncap_first}_${pro.name}" name="create_${model.name?uncap_first}_${pro.name}" class="form-control">
                                <option value="1" selected>是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                        <#elseif pro.type == 'Reference'  >
                        <label class="col-sm-3 control-label" for="create_${model.name?uncap_first}_${pro.name}_id"><#if pro.required == true><span class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <select id="create_${model.name?uncap_first}_${pro.name}_id" name="create_${model.name?uncap_first}_${pro.name}_id" class="form-control" style="width: 100%">
                            </select>
                        </div>
                        <#elseif pro.type == 'SimpleConfig' >
                        <label class="col-sm-3 control-label" for="create_${model.name?uncap_first}_${pro.name}_code"><#if pro.required == true><span class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <select id="create_${model.name?uncap_first}_${pro.name}_code" name="create_${model.name?uncap_first}_${pro.name}_code" class="form-control" style="width: 100%">
                            </select>
                        </div>
                        <#elseif pro.type=='Text'>
                        <label class="col-sm-3 control-label" for="create_${model.name?uncap_first}_${pro.name}"><#if pro.required == true><span class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <textarea id="create_${model.name?uncap_first}_${pro.name}" name="create_${model.name?uncap_first}_${pro.name}" class="autosize-transition form-control"></textarea>
                        </div>
                        <#else>
                        <label class="col-sm-3 control-label" for="create_${model.name?uncap_first}_${pro.name}"><#if pro.required == true><span class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <input type="text" id="create_${model.name?uncap_first}_${pro.name}" name="create_${model.name?uncap_first}_${pro.name}" class="form-control">
                        </div>
                        </#if>
                    </div>
                </#list>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="${model.name?uncap_first}_btn_create_save">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改 -->
<div class="modal inmodal" id="modal_form_update_${model.name?uncap_first}" tabindex="-1" role="dialog"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated bounceInRight">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title">修改${model.displayName}</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <input type="hidden" id="update_${model.name?uncap_first}_id"/>
                    </div>
                    <#list model.attribute as pro>
                    <div class="form-group">
                    <#if pro.type == 'DateTime' || pro.type=='Date'>
                        <label class="col-sm-3 control-label"
                               for="update_${model.name?uncap_first}_${pro.name}"><#if pro.required == true><span
                                class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <div class="input-group date">
                                <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                <input type="text" class="form-control"
                                       id="update_${model.name?uncap_first}_${pro.name}"
                                       name="update_${model.name?uncap_first}_${pro.name}">
                            </div>
                        </div>

                    <#elseif pro.type=='Boolean'>
                        <label class="col-sm-3 control-label"
                               for="update_${model.name?uncap_first}_${pro.name}"><#if pro.required == true><span
                                class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <select id="update_${model.name?uncap_first}_${pro.name}"
                                    name="update_${model.name?uncap_first}_${pro.name}" class="form-control">
                                <option value="1" selected>是</option>
                                <option value="0">否</option>
                            </select>
                        </div>
                    <#elseif pro.type == 'Reference'  >
                        <label class="col-sm-3 control-label"
                               for="update_${model.name?uncap_first}_${pro.name}_id"><#if pro.required == true><span
                                class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <select id="update_${model.name?uncap_first}_${pro.name}_id"
                                    name="update_${model.name?uncap_first}_${pro.name}_id" class="form-control"
                                    style="width: 100%">

                            </select>
                        </div>
                    <#elseif pro.type == 'SimpleConfig' >
                        <label class="col-sm-3 control-label"
                               for="update_${model.name?uncap_first}_${pro.name}_code"><#if pro.required == true><span
                                class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <select id="update_${model.name?uncap_first}_${pro.name}_code"
                                    name="update_${model.name?uncap_first}_${pro.name}_code" class="form-control"
                                    style="width: 100%">

                            </select>
                        </div>
                    <#elseif pro.type=='Text'>
                        <label class="col-sm-3 control-label"
                               for="update_${model.name?uncap_first}_${pro.name}"><#if pro.required == true><span
                                class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <textarea id="update_${model.name?uncap_first}_${pro.name}"
                                      name="update_${model.name?uncap_first}_${pro.name}"
                                      class="autosize-transition form-control"></textarea>
                        </div>
                    <#else>
                        <label class="col-sm-3 control-label"
                               for="update_${model.name?uncap_first}_${pro.name}"><#if pro.required == true><span
                                class="red">*</span></#if>${pro.displayName}:</label>
                        <div class="col-sm-9 controls">
                            <input type="text" id="update_${model.name?uncap_first}_${pro.name}"
                                   name="update_${model.name?uncap_first}_${pro.name}" class="form-control">
                        </div>
                    </#if>
                    </div>
                    </#list>
                    <div class="form-group" style="display: none">
                        <label class="col-sm-3 control-label" for="update_${model.name?uncap_first}_creator"><span
                                class="red">*</span>创建人:</label>
                        <div class="col-sm-9 controls">
                            <input type="text" id="update_${model.name?uncap_first}_creator" name="update_${model.name?uncap_first}_creator" class="form-control">
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="${model.name?uncap_first}_btn_update_save">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 全局js -->
<script src="/js/jquery.min.js?v=2.1.4"></script>
<script src="/js/bootstrap.min.js?v=3.3.6"></script>
<!-- Bootstrap table -->
<script src="/js/plugins/bootstrap-table/bootstrap-table.js"></script>
<script src="/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
<script src="/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>

<script src="/js/plugins/bootstrap-table/extensions/treegrid/bootstrap-table-treegrid.js"></script>
<script src="/js/plugins/treegrid/jquery.treegrid.js"></script>

<!-- Sweet alert -->
<script src="/js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="/js/plugins/fullcalendar/moment.min.js"></script>
<script src="/js/plugins/toastr/toastr.min.js"></script>
<script src="/js/plugins/select2/select2.full.min.js"></script>
<script src="/js/plugins/datapicker/bootstrap-datepicker.js"></script>

<script src="/js/plugins/jquery-ztree/3.5/js/jquery.ztree.all-3.5.js" type="text/javascript"></script>

<!-- 自定义js -->
<script src="/js/content.js?v=1.0.0"></script>
<script src="/js/common.js" type="text/javascript" ></script>

<script type="text/javascript">

    var ${model.name?uncap_first}BaseUrl = "/business/${domain.name?uncap_first}/${model.name?uncap_first}";
    var $${model.name?uncap_first}Table = $('#${model.name?uncap_first}_table');
    $${model.name?uncap_first}Table.bootstrapTable({
        method: 'GET',
        url: ${model.name?uncap_first}BaseUrl + "/list",
        ajaxOptions: {
            beforeSend: function (request) {
                request.setRequestHeader("Authorization", localStorage.getItem("Authorization"));
            }
        },
        dataField: "data",
        cache: false,               //是否使用缓存，默认为true
        striped: true,              //是否显示行间隔色
        pagination: true,           //是否显示分页
        pageSize: 10,               //每页的记录行数
        pageNumber: 1,              //初始化加载第一页，默认第一页
        pageList: [10, 20, 50],     //可供选择的每页的行数
        clickToSelect: true,        //是否启用点击选中行
        singleSelect: true,
        sidePagination: "server",   //分页方式：client客户端分页，server服务端分页
        queryParams: function (params) {//自定义参数，这里的参数是传给后台的，我这是是分页用的
            return queryParams(params);
        },   //查询参数组织方式
        idField: "id",
        columns: [{
            checkbox: true
        }
        <#list model.attribute as pro>
        , {
            align: "center",
            valign: "middle",
            title: "${pro.displayName}",
            <#if pro.type == 'Reference' || pro.type == 'SimpleConfig'||pro.type=='Files' >
            field: "${pro.name}Name",
            <#else >
            field: "${pro.name}",
            </#if>
            visible: <#if pro.visibility>true<#else>false</#if>,
            orderable: false,
            <#if pro.type == 'DateTime'>
            formatter: function (value, row, index) {
                var result = '';
                if (value) {
                    result = moment(value).format('YYYY-MM-DD HH:mm:ss');
                }
                return result;
            }
            <#elseif pro.type == 'Date'>
            formatter: function (value, row, index) {
                var result = '';
                if (value) {
                    result = moment(value).format('YYYY-MM-DD');
                }
                return result;
            }
            <#elseif pro.type=='Boolean'>
            formatter: function (value, row, index) {
                return (value ? "<i class=\"green fa fa-check-circle\"></i>" : "<i class=\"red fa fa-minus-circle\"></i>");
            }
            <#else>
            formatter: CONSTANT.BOOTSTRAP_TABLES.RENDER.ELLIPSIS
            </#if>

        }
        </#list>
        ],
        formatNoMatches: function () {
            return '无符合条件的记录';
        }
    });

    //查询参数
    function queryParams(params) {
        var queryParams = {};
        var condition = {};

        if ($("#name_search").val() != '') {
            condition.name = $('#name_search').val();
        }

        <#list model.attribute as pro>
            <#if pro_index == 0 || pro.inSearch>
                <#if pro.type == 'DateTime' || pro.type == 'Date'>
        if ($("#${model.name?uncap_first}_${pro.name}_start_search").val() != '') {
            condition.${pro.name}Start = $("#${model.name?uncap_first}_${pro.name}_start_search").val();
        }
        if ($("#${model.name?uncap_first}_${pro.name}_end_search").val() != '') {
            condition.${pro.name}End = $("#${model.name?uncap_first}_${pro.name}_end_search").val();
        }
                <#elseif pro.type == 'Boolean'>
        if ($("#${model.name?uncap_first}_${pro.name}_search").val() != '') {
            condition.${pro.name} = $("#${model.name?uncap_first}_${pro.name}_search").val() == "1" ? true : $("#${model.name?uncap_first}_${pro.name}_search").val() == "0" ? false : null;
        }
                <#elseif pro.type == 'Reference'>
        if ($("#${model.name?uncap_first}_${pro.name}_id_search").val() != '') {
            condition.${pro.name}Id = $("#${model.name?uncap_first}_${pro.name}_id_search").val();
        }
                <#elseif pro.type == 'SimpleConfig'>
        if ($("#${model.name?uncap_first}_${pro.name}_code_search").val() != '') {
            condition.${pro.name}Code = $("#${model.name?uncap_first}_${pro.name}_code_search").val();
        }
                <#else >
        if ($("#${model.name?uncap_first}_${pro.name}_search").val() != '') {
            condition.${pro.name} = $("#${model.name?uncap_first}_${pro.name}_search").val();
        }
                </#if>
            </#if>
        </#list>
        queryParams.page = params.offset / params.limit + 1;
        queryParams.limit = params.limit;
        queryParams.searchCondition = condition;
        return "params=" + encodeURI(JSON.stringify(queryParams));
    }

    //刷新表格
    $("#${model.name?uncap_first}_btn_refresh").click(function () {
        $${model.name?uncap_first}Table.bootstrapTable('refresh');
    });

    //显示查询条件
    $("#${model.name?uncap_first}_btn_search").click(function () {
        $('#${model.name?uncap_first}_search_form').toggle();
    });
    //查询操作
    $('#${model.name?uncap_first}_search').click(function () {
        $${model.name?uncap_first}Table.bootstrapTable('refresh');
    });
    //重置操作
    $('#${model.name?uncap_first}_reset').click(function () {
        $("#name_search").val('');
        <#list model.attribute as pro>
            <#if pro.type == 'DateTime'>
                $("#${model.name?uncap_first}_${pro.name}_start_search").val('');
                $("#${model.name?uncap_first}_${pro.name}_end_search").val('');
            <#elseif pro.type == 'Date'>
                $("#${model.name?uncap_first}_${pro.name}_start_search").val('');
                $("#${model.name?uncap_first}_${pro.name}_end_search").val('');
            <#elseif pro.type=='Boolean'>
                $("#${model.name?uncap_first}_${pro.name}_search").val('');
            <#elseif pro.type == 'Reference'>
                $("#${model.name?uncap_first}_${pro.name}_id_search").val('');
            <#elseif pro.type == 'SimpleConfig' >
                $("#${model.name?uncap_first}_${pro.name}_code_search").val(null).trigger('change');
            <#else>
                $("#${model.name?uncap_first}_${pro.name}_search").val('');
            </#if>
        </#list>
        $${model.name?uncap_first}Table.bootstrapTable('refresh');

    });

    function checkItem(param) {
        var integerReg = /^(\+|-)?\d+$/;
        <#list model.attribute as pro>
            <#if pro.required == true>
                <#if pro.type == 'Reference'>
                if (param.${pro.name}Id == null || param.${pro.name}Id == '') {
                    toastr.error("${pro.displayName}不能为空");
                    return false;
                }
                <#elseif pro.type == 'SimpleConfig' >
                if (param.${pro.name}Code == null || param.${pro.name}Code == '') {
                    toastr.error("${pro.displayName}不能为空");
                    return false;
                }
                <#elseif pro.type == 'Boolean' >
                if (param.${pro.name} == null) {
                    toastr.error("${pro.displayName}不能为空");
                    return false;
                }
                <#else >
                if (param.${pro.name} == null || param.${pro.name} == '') {
                    toastr.error("${pro.displayName}不能为空");
                    return false;
                }
                </#if>
            </#if>
            <#if pro.type=='Integer' || pro.type=='Long'>
                if (param.${pro.name} != null && !integerReg.test(param.${pro.name})) {
                    toastr.error("${pro.displayName}必须为整数");
                    return false;
                }
            <#elseif pro.type=='Double'>
                if (param.${pro.name} != null && isNaN(param.${pro.name})) {
                    toastr.error("${pro.displayName}必须为数字");
                    return false;
                }
            </#if>
        </#list>
        return true;
    }

    //新增
    $('#${model.name?uncap_first}_btn_create').click(function () {
        $('#modal_form_create_${model.name?uncap_first}').modal();
    });
    $('#${model.name?uncap_first}_btn_create_save').click(function () {
        var ${model.name?uncap_first} ={};
            <#list model.attribute as pro>
                <#if pro.type == 'DateTime'>
                    if ($("#create_${model.name?uncap_first}_${pro.name}").val() != '') {
                        ${model.name?uncap_first}.${pro.name} = $("#create_${model.name?uncap_first}_${pro.name}").val();
                        var dateTime = moment(${model.name?uncap_first}.${pro.name}, "YYYY-MM-DD HH:mm:ss");
                        ${model.name?uncap_first}.${pro.name} = dateTime.valueOf();
                    }
                <#elseif pro.type == 'Date'>
                    if ($("#create_${model.name?uncap_first}_${pro.name}").val() != '') {
                        ${model.name?uncap_first}.${pro.name} = $("#create_${model.name?uncap_first}_${pro.name}").val();
                        var dateTime = moment(${model.name?uncap_first}.${pro.name}, "YYYY-MM-DD");
                        ${model.name?uncap_first}.${pro.name} = dateTime.valueOf();
                    }
                <#elseif pro.type=='Boolean'>
                    ${model.name?uncap_first}.${pro.name} = Boolean(Number($("#create_${model.name?uncap_first}_${pro.name}").val()));
                <#elseif pro.type == 'Reference'>
                    ${model.name?uncap_first}.${pro.name}Id = $("#create_${model.name?uncap_first}_${pro.name}_id").val();
                <#elseif pro.type == 'SimpleConfig' >
                    ${model.name?uncap_first}.${pro.name}Code = $("#create_${model.name?uncap_first}_${pro.name}_code").val();
                <#else>
                    ${model.name?uncap_first}.${pro.name} = $("#create_${model.name?uncap_first}_${pro.name}").val();
                </#if>
            </#list>
        if (!checkItem(${model.name?uncap_first})) {
            return false;
        }

        $.ajax({
            type: "POST",
            url: ${model.name?uncap_first}BaseUrl,
            async: false,
            cache: false,   //禁用缓存
            data: JSON.stringify(${model.name?uncap_first}), //传入已封装的参数
            contentType: "application/json;charset=UTF-8",
            success: function (response) {
                if (response.success) {
                    toastr.success(response.msg);
                    $('#modal_form_create_${model.name?uncap_first}').modal("hide");
                    $${model.name?uncap_first}Table.bootstrapTable('refresh');
                    return;
                }
                toastr.error(response.msg);
            }
        });
    });


    //更新数据
    $("#${model.name?uncap_first}_btn_update").click(function () {
        var arrSelections = $${model.name?uncap_first}Table.bootstrapTable('getSelections');
        if (arrSelections.length <= 0) {
            toastr.warning('请选择有效操作行');
            return;
        }
        if (arrSelections.length > 1) {
            toastr.warning('只能选择一行进行编辑！');
            return;
        }
        $('#modal_form_update_${model.name?uncap_first}').modal();
        //填充数据 ${model.name?uncap_first}
        var item = arrSelections[0];
        $("#update_${model.name?uncap_first}_id").val(item.id);
        $("#update_${model.name?uncap_first}_creator").val(item.creator);

        <#list model.attribute as pro>
            <#if pro.type == 'DateTime'>
                var time = '';
                if (item.${pro.name}) {
                    time = moment(item.${pro.name}).format('YYYY-MM-DD HH:mm:ss')
                }
                $("#update_${model.name?uncap_first}_${pro.name}").val(time);
            <#elseif pro.type == 'Date'>
                var time = '';
                if (item.${pro.name}) {
                    time = moment(item.${pro.name}).format('YYYY-MM-DD')
                }
                $("#update_${model.name?uncap_first}_${pro.name}").val(time);
            <#elseif pro.type=='Boolean'>
                $("#update_${model.name?uncap_first}_${pro.name}").val(item.${pro.name}? "1" : "0");
            <#elseif pro.type == 'Reference'>
                $("#update_${model.name?uncap_first}_${pro.name}_id").empty().append("<option value='" + item.${pro.name}Id + "' >" + item.${pro.name}Name + "</option>");
            <#elseif pro.type == 'SimpleConfig' >
                $("#update_${model.name?uncap_first}_${pro.name}_code").empty().append("<option value='" + item.${pro.name}Code + "' >" + item.${pro.name}Name + "</option>");
            <#else>
                $("#update_${model.name?uncap_first}_${pro.name}").val(item.${pro.name});
            </#if>
        </#list>
    });
    $('#${model.name?uncap_first}_btn_update_save').click(function () {
        var ${model.name?uncap_first} ={};
    ${model.name?uncap_first}.id = $("#update_${model.name?uncap_first}_id").val();
    ${model.name?uncap_first}.creator = $("#update_${model.name?uncap_first}_creator").val();

    <#list model.attribute as pro>
        <#if pro.type == 'DateTime'>
        if ($("#update_${model.name?uncap_first}_${pro.name}").val() != '') {
            ${model.name?uncap_first}.${pro.name} = $("#update_${model.name?uncap_first}_${pro.name}").val();
            var dateTime = moment(${model.name?uncap_first}.${pro.name}, "YYYY-MM-DD HH:mm:ss");
            ${model.name?uncap_first}.${pro.name} = dateTime.valueOf();
        }
        <#elseif pro.type == 'Date'>
        if ($("#update_${model.name?uncap_first}_${pro.name}").val() != '') {
            ${model.name?uncap_first}.${pro.name} = $("#update_${model.name?uncap_first}_${pro.name}").val();
            var dateTime = moment(${model.name?uncap_first}.${pro.name}, "YYYY-MM-DD");
            ${model.name?uncap_first}.${pro.name} = dateTime.valueOf();
        }
        <#elseif pro.type=='Boolean'>
            ${model.name?uncap_first}.${pro.name} = Boolean(Number($("#update_${model.name?uncap_first}_${pro.name}").val()));
        <#elseif pro.type == 'Reference' >
            ${model.name?uncap_first}.${pro.name}Id = $("#update_${model.name?uncap_first}_${pro.name}_id").val();
        <#elseif pro.type == 'SimpleConfig' >
            ${model.name?uncap_first}.${pro.name}Code = $("#update_${model.name?uncap_first}_${pro.name}_code").val();
        <#elseif pro.type == 'Files' >
            ${model.name?uncap_first}.${pro.name}Id = $("#update_${model.name?uncap_first}_${pro.name}_id").val();
        <#else>
            ${model.name?uncap_first}.${pro.name} = $("#update_${model.name?uncap_first}_${pro.name}").val();
        </#if>
    </#list>
        if (!checkItem(${model.name?uncap_first})) {
            return false;
        }
        $.ajax({
                    type: "PUT",
                    url: ${model.name?uncap_first}BaseUrl + "/" + ${model.name?uncap_first}.id,
                async: false,
                cache: false,   //禁用缓存
                data: JSON.stringify(${model.name?uncap_first}), //传入已封装的参数
                contentType: "application/json;charset=UTF-8",
                success: function (response) {
            if (response.success) {
                toastr.success(response.msg);
                $('#modal_form_update_${model.name?uncap_first}').modal("hide");
                $${model.name?uncap_first}Table.bootstrapTable('refresh');
                return;
            }
            toastr.error(response.msg);
        }
    });
    });

    //删除操作
    $('#${model.name?uncap_first}_btn_delete').click(function () {
        var arrSelections = $${model.name?uncap_first}Table.bootstrapTable('getSelections');
        if (arrSelections.length <= 0) {
            toastr.warning('请选择有效操作行');
            return;
        }
        swal({
            title: "您确定要删除这条数据吗",
            text: "删除后将无法恢复，请谨慎操作！",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function () {
            var selectItemIds = "";
            jQuery.each(arrSelections, function (i, selection) {
                if (selectItemIds === "") {
                    selectItemIds = selection.id;
                } else {
                    selectItemIds = selectItemIds + "," + selection.id;
                }
            });
            $.ajax({
                type: "DELETE",
                url: ${model.name?uncap_first}BaseUrl + "/" + selectItemIds,
                success: function (response) {
                    if (response.success) {
                        swal({
                            title: response.title,
                            text: response.msg,
                            type: "success",
                            allowOutsideClick: true
                        });
                        $${model.name?uncap_first}Table.bootstrapTable('refresh');
                        return;
                    }
                    swal({
                        title: response.title,
                        text: response.msg,
                        type: "error",
                        allowOutsideClick: true
                    });
                }
            });
        });
    });
<#list model.attribute as pro>
    <#if pro.type == 'DateTime' >
    $('.input-group.date').datepicker({
        todayBtn: "linked",
        keyboardNavigation: false,
        forceParse: false,
        calendarWeeks: true,
        autoclose: true
    });
    $('.input-daterange').datepicker({
        keyboardNavigation: false,
        forceParse: false,
        autoclose: true
    });
    <#elseif pro.type == 'Reference'  >
   var ${model.name?uncap_first}_${pro.name}IdAjaxConfig = {
       type: "GET",
       url: "/business/${pro.reference.domain.name?uncap_first}/${pro.reference.name?uncap_first}/listAll/",
       processResults: function (response) {
           if (response.success) {
               var resultList = [];
               for (var i in response.data) {
                   resultList.push({id: response.data[i].code, text: response.data[i].name})
               }
               return {
                   results: resultList
               };
           }
       },
       cache: false
   };
    $("#${model.name?uncap_first}_${pro.name}_id_search").select2({
        minimumResultsForSearch: Infinity,
        placeholder: '点击选择',
        allowClear: true,
        ajax: ${model.name?uncap_first}_${pro.name}IdAjaxConfig
    });
    $("#create_${model.name?uncap_first}_${pro.name}_id").select2({
        minimumResultsForSearch: Infinity,
        placeholder: '点击选择',
        allowClear: true,
        ajax: ${model.name?uncap_first}_${pro.name}IdAjaxConfig
    });
    $("#update_${model.name?uncap_first}_${pro.name}_id").select2({
        minimumResultsForSearch: Infinity,
        placeholder: '点击选择',
        allowClear: true,
        ajax: ${model.name?uncap_first}_${pro.name}IdAjaxConfig
    });
    <#elseif pro.type == 'SimpleConfig' >
    var ${model.name?uncap_first}_${pro.name}CodeAjaxConfig = {
        type: "GET",
        url: "/admin/dict/dictionaryItem/listAll/${improvedNamingStrategy(model.name?cap_first)?upper_case}_${improvedNamingStrategy(pro.name?cap_first)?upper_case}",
        processResults: function (response) {
            if (response.success) {
                var resultList = [];
                for (var i in response.data) {
                    resultList.push({id: response.data[i].code, text: response.data[i].name})
                }
                return {
                    results: resultList
                };
            }
        },
        cache: false
    };
    $("#${model.name?uncap_first}_${pro.name}_code_search").select2({
        minimumResultsForSearch: Infinity,
        placeholder: '点击选择',
        allowClear: true,
        ajax: ${model.name?uncap_first}_${pro.name}CodeAjaxConfig
    });
    $("#create_${model.name?uncap_first}_${pro.name}_code").select2({
        minimumResultsForSearch: Infinity,
        placeholder: '点击选择',
        allowClear: true,
        ajax: ${model.name?uncap_first}_${pro.name}CodeAjaxConfig
    });
    $("#update_${model.name?uncap_first}_${pro.name}_code").select2({
        minimumResultsForSearch: Infinity,
        placeholder: '点击选择',
        allowClear: true,
        ajax: ${model.name?uncap_first}_${pro.name}CodeAjaxConfig
    });
    </#if>
</#list>
</script>
<script>
    $(".dropdown-toggle").on('click', function(){
        $(this).siblings(".dropdown-menu").toggle()
    });
    $(document).mouseup(function(e){
        var panel = $(".search-panel");
        var modal = $(".modal");
        if( !panel.is(e.target) && panel.has(e.target).length === 0 && !modal.is(e.target) && modal.has(e.target).length === 0 ){
            $(".dropdown-menu").hide()
        }
    });
</script>
</body>
</html>
