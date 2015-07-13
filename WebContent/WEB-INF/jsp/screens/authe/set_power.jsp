<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新越网后台管理系统_权限管理</title>
<link href="../css/style.css" type="text/css" rel="stylesheet" />
<%@ include file="../../commons/common.jsp" %>
<link type="text/css" rel="stylesheet" href="${ctx}/css/ui.jqgrid.css">
 <link rel="stylesheet" href="${ctx}/css/jquery-ui.min.css">
 <script src="${ctx}/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ctx}/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.jqGrid.min.js"></script>
</head>

<body> 
<div class="c_right">
<div class="c_r_bt"><h1><img src="${ctx}/images/qx_tb1.png" alt="权限管理"/><span>管理员列表</span></h1><a href="${ctx}/authe/adminadd">添加管理员</a></div>
<div style="padding-left:10px"><table id="list"></table></div>
<div id="pager"></div>
<div id="admindlg" style="display:none">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="150" height="24" align="right">用户名：</td>
    <td width="89%"><div id="username"></div></td>
  </tr>
  <tr>
    <td height="24" align="right">姓名：</td>
    <td><input type="text" class="t1" name="name" id="name"/></td>
  </tr>
  <tr>
    <td height="24" align="right">手机号：</td>
    <td><input type="text" class="t1" name="phone" id="phone" /></td>
  </tr>
  <tr>
    <td height="24" align="right">职位：</td>
    <td><input type="text" class="t1" name="position" id="position"/></td>
  </tr>
  <tr>
    <td height="24" align="right">所属机构：</td>
    <td><div id="orgname"></div></td>
  </tr>
  <tr>
    <td colspan="2" align="center" id="errmsg" style="color:#F00">&nbsp;</td>
  </tr>
  <tr>
    <td height="88" align="right">权限设置：</td>
    <td><input name="gid" type="checkbox" value="1"/>权限管理　　
    <input name="gid" type="checkbox" value="2"/>会员管理　　
    <input name="gid" type="checkbox" value="3"/>企业信息管理<br />
      <input name="gid" type="checkbox" value="4"/>企业实名认证
      <input name="gid" type="checkbox" value="5"/>贷款产品管理
      <input name="gid" type="checkbox" value="6"/>机构管理<br />
      <input name="gid" type="checkbox" value="7"/>
      新闻管理　　
      <input name="gid" type="checkbox" value="8"/>帮助中心管理
      <input name="gid" type="checkbox" value="9"/>城市分站管理<br />
      <input name="gid" type="checkbox" value="10"/>
      广告位管理　
      <input name="gid" type="checkbox" value="11"/>友情链接管理
      <input name="gid" type="checkbox" value="12"/>合作机构管理</td>
  </tr>
  <tr>
    <td height="78" align="right">贷款订单管理：</td>
    <td>
      <input name="gid" type="checkbox" value="13"/>
      快速申贷订单</span> <span>
      <input name="gid" type="checkbox" value="14"/>
      等待审核订单</span> <span>
      <input name="gid" type="checkbox" value="15"/>
      新越网审核通过订单</span> <br /><span>
      <input name="gid" type="checkbox" value="16"/>
      新越网审核不通过订单</span> <span>
      <input name="gid" type="checkbox" value="17"/>
      银行审核通过订单</span> <span>
      <input name="gid" type="checkbox" value="18"/>
      银行审核不通过订单</span><br /> <span>
      <input name="gid" type="checkbox" value="19"/>
      银行已经放贷订单</span></span></td>
  </tr>
  <tr>
    <td align="right">是否启用：</td>
    <td><span class="dx">
      <input type="radio" name="qy" value="0" id="qy1" />
      是</span><span class="dx">
      <input type="radio" name="qy" value="1" id="qy2"/>
      否</span></td>
  </tr>
</table>
</div> 
<div id="dialog-confirm" title="确定要删除?" style="display:none">
  <div>确定要删除此管理员?</div>
</div>  
</body>
<script language="javascript">
$(function(){
	pageInit();
	
});

function re_set(){
	$("#username").text("");
	$("#name").val("");
	$("#phone").val("");
	$("#position").val("");
	$("#orgname").text("");
	$("#errmsg").text("");
	$("input[name='gid']").each(function(){
		$(this).prop("checked",false);				
	});
	$("#qy1").attr("checked",false);
	$("#qy2").attr("checked",false);
}

function deladmin(id){
	$( "#dialog-confirm" ).dialog({
      resizable: false,
      height:200,
      modal: true,
      buttons: {
        "确定删除": function() {
				$.post("${ctx}/authe/deladmin", { id: id },
   				function(data){
   				if (data.result=="true"){
   					jQuery("#list").trigger("reloadGrid");
				}
   }, "json");	
          $( this ).dialog( "close" );
        },
        "取  消": function() {
          $( this ).dialog( "close" );
        }
      }
    });
}

function editadmin(id){
	re_set();
	$.post("${ctx}/authe/admininfobyid", { "id": id },
   		function(data){
   			$("#username").text(data.username);
			$("#name").val(data.name);
			$("#phone").val(data.phone);
			$("#position").val(data.position);
			$("#orgname").text(data.orgname);

			if (data.status=="0"){
				
				$("#qy1").prop("checked",true);	
			}
			else{
				$("#qy2").prop("checked",true);
			}
			var gid = data.groupid;
		
			if (gid!=""){
				var glist = gid.split(",");
				$("input[name='gid']").each(function(){
    				for (var i=0;i<glist.length;i++){
						if ($(this).val()==glist[i]){
							$(this).prop("checked",true);
							break;
						}
					}
				})
			}
   		}, "json");
	$("#admindlg").attr("title","修改管理员信息");
    		$( "#admindlg" ).dialog({
      			resizable: false,
      			height:460,
	  			width:650,
      			modal: true,
      			show: "blind",
      			buttons: {
        			"修改": function() {
					var g_id = "";
					$("input[name='gid']").each(function(){
    				if ($(this).is(':checked')==true){
    					if (g_id!="")
    						g_id += ",";
    		
    					g_id += $(this).val();
    				}
   });	
   					var nName = $("#name").val();
					var nPhone = $("#phone").val();
					var nPosition = $("#position").val();
					var nStatus = $("input:radio:checked").val(); 
					$.post("${ctx}/authe/admininfoupdate", { "id": id ,"phone":nPhone,"name":nName,"position":nPosition,"status":nStatus,"gid":g_id},
					function(data){
						if (data.result=="true"){
							$("#admindlg").dialog( "close" );
							jQuery("#list").trigger("reloadGrid");
						}
						else{
							$("#errmsg").text("修改数据失败");
						}
					},"json")
        			},
        			"取消": function() {
          				$("#admindlg").dialog( "close" );
        		}
      		}
    	});
}

function pageInit(){
	jQuery("#list").jqGrid(
	      {
	        url : "${ctx}/authe/adminlistjson",
	        datatype : "json",
	        autowidth : true,
	        colNames : [ '序号', '用户名','姓名','手机号','所属机构编号','机构名称','状态','操作'],
	        colModel : [ 
	                     {name : 'id',index : 'id',width : 40, sortable : false}, 
	                     {name : 'username',index : 'username',width:200,sortable : false},
						 {name : 'name',index : 'name',width:100,sortable : false},
						 {name : 'phone',index : 'phone',width:100,sortable : false},
						 {name : 'orgcode',index : 'orgcode',width:100,sortable : false},
						 {name : 'orgname',index : 'orgname',width:300,sortable : false},
						 {name : 'status',index : 'status',width:60,sortable : false,align : "center"},
						 {name:'Edit',index:'Edit', width:200,align : "center",sortable : false} 
	                   ],
	        rowNum : 10,
	        height : 510,
	        rowList : [ 10, 20, 30 ],
	        pager : '#pager',
	        sortname : 'id',
	        mtype : "post",
	  //      sortorder : "asc",
	        caption : "管理员列表",
			gridComplete: function () {
				
          		var ids = jQuery("#list").jqGrid('getDataIDs');
          		for (var i = 0; i < ids.length; i++) {
          			var id = ids[i];
					var rowData = $("#list").getRowData(id);
					var editBtn = "<a href='javascript:deladmin(\""+id+"\")' style='color:#f60'>删除</a>　";
					editBtn +=  "<a href='javascript:editadmin(\""+id+"\")' style='color:#f60'>修改</a>"
					jQuery("#list").jqGrid('setRowData', ids[i], { Edit: editBtn });
          		}

         	}, 
	        onSelectRow : function(ids) {
				fN =jQuery("#list").getCell(ids,"funame");
				selectFu = ids;
				$("#bCmd").removeAttr("disabled");
				jQuery("#listcmd").jqGrid("clearGridData");	
                  jQuery("#listcmd").jqGrid(
                      'setGridParam',
                      {
                        url : "${ctx}/authe/adminlistjson"
                            + ids,
                        page : 1
                      });
                  jQuery("#listcmd").jqGrid('setCaption',
                      "功能名称：" + fN).trigger(
                      'reloadGrid');
				
	        }
	      });
		  
	
}

</script>
</html>
