<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" type="text/css" href="http://dev.auto007.com:9090/js/public/jquery-easyui-1.4.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="http://dev.auto007.com:9090/js/public/jquery-easyui-1.4.4/themes/icon.css">
<link rel="stylesheet" type="text/css" href="http://dev.auto007.com:9090/js/public/jquery-easyui-1.4.4/demo/demo.css">
<script type="text/javascript" src="http://dev.auto007.com:9090/js/public/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>

<script type="text/javascript">
ocatalogDataObj = {};
$("#brandListDiv .ocatalogsUL li").click(function(){
	$(".model").removeClass("show");
	$(".model").addClass("hidden");
  	
	$("#modelContent").removeClass("hidden");
	$("#modelContent").addClass("show");
	
	var sBrand = $("div",this).attr("brand");
	var sBrandCn = $("div",this).text();
	
	ocatalogDataObj.currentBrand = sBrand;
	
	ocatalogDataObj[sBrand]={};
	ocatalogDataObj[sBrand].brandName = sBrandCn;
	ocatalogDataObj[sBrand].layersData = {};
	
	$.ajax({
	   type:"GET",
	   url:"/ocatalogs/brand/"+sBrand,
	   dataType:"json",
	   beforeSend: function(){
		   $("#selectedBrand").text('('+sBrandCn+')');
	   }, 
	   success: function(data){

		   ocatalogDataObj[data.brand].configLayers = data.configLayers;
		   ocatalogDataObj[data.brand].layersData[data.layer_id]={};
		   
		   ocatalogDataObj[data.brand].layersData[data.layer_id].configFields = data.configFields;
		   ocatalogDataObj[data.brand].layersData[data.layer_id].dataList = data.dataList;

		   for(var li = 0;li<data.configLayers.length;li++){
			   if(li == 0){
				   $("#modelLayerNav").append('<div id="layer_id_'+data.configLayers[li].id+'" layer_id="'+data.configLayers[li].id+'" class ="modelNav on">选择'+data.configLayers[li].cat_name_cn+'<b></b></div>');
			   } else {
				   $("#modelLayerNav").append('<div id="layer_id_'+data.configLayers[li].id+'" layer_id="'+data.configLayers[li].id+'" class ="modelNav">选择'+data.configLayers[li].cat_name_cn+'<b></b></div>');
			   }
		   }
		   
		   $("#modelContent").html('');
		   
		   var htmlStr = '';
		   if(data.configFields && data.configFields.length > 1){
			   
		   } else {
			   htmlStr += '<ul class="modelUl">';
			   var dr = null;
			   for(var i = 0; i< data.dataList.length; i++){
				   dr =  data.dataList[i];
				   //htmlStr += "<li>";
				   htmlStr += "<li data = '"+JSON.stringify(dr)+"'>";
				   //htmlStr += '<img alt="'+dr.model_name+'" src="http://www.auto007.com'+dr.img_path+'">';
				   htmlStr += '<div>'+dr[data.configFields[0].field_name]+'</div>';
				   htmlStr += '</li>';
			   }
			   htmlStr += '</ul>';
		   }
		   $("#modelContent").append(htmlStr);
		   $("#modelContent").attr('brand', data.brand);
		   $("#modelContent").attr('layer_id', data.layer_id);
	   }, 
	   error: function(){
		   
	   },
	   complete: function(data){
		   //alert(data);
	   }
	});
});


$("#modelContent .modelTable tr").live("click",function(){
	var data = eval("(" + $(this).attr("data") + ")");
	var brand = $("#modelContent").attr("brand");
	var layerId = $("#modelContent").attr("layer_id");
	var value = $('td',this).first().text();
	getModel(brand, layerId, data, value)
});

$("#modelContent .modelUl li").live("click",function(){
	var data = eval("(" + $(this).attr("data") + ")");
	var brand = $("#modelContent").attr("brand");
	var layerId = $("#modelContent").attr("layer_id");
	var value = $('div',this).text();
	getModel(brand, layerId, data, value);
});

function getModel(brand, layerId, data, value){
	
	$("#layer_id_"+layerId+" b").text('('+value+')');
	
	var configLayers = ocatalogDataObj[brand].configLayers;
	
	if(layerId == configLayers[configLayers.length-1].id){
		$("#modelContent").removeClass("show");
		$("#modelContent").addClass("hidden");
		addPanel(ocatalogDataObj[brand].brandName+" - "+value);
		return;
	}
	
	var paramUrl = "";
	for (key in data) {
	    paramUrl += key;
	    paramUrl += "=";
	    paramUrl += data[key];
	    paramUrl += "&";
	}
	
	paramUrl = paramUrl.substring(0, paramUrl.length-1);
	
	$.ajax({
	   type:"GET",
	   url:"/ocatalogs/brand/"+brand+"/model/layer-"+layerId +"?"+paramUrl,
	   dataType:"json",
	   beforeSend: function(){
		   $("#modelContent").html('加载中......');
	   }, 
	   success: modelLayerHtml, 
	   error: function(){
		   
	   },
	   complete: function(data){
		   //alert(data);
	   }
	});
}

function modelLayerHtml(data){
	ocatalogDataObj[data.brand].layersData[data.layer_id]={};
	   
   	ocatalogDataObj[data.brand].layersData[data.layer_id].configFields = data.configFields;
   	ocatalogDataObj[data.brand].layersData[data.layer_id].dataList = data.dataList;
   	
   	$("#modelContent").html('');
   	
   	$("#layer_id_"+data.layer_id).addClass("on");
   	
   	var htmlStr = '';
	if(data.configFields && data.configFields.length > 1){
		htmlStr += '<table class="modelTable">';
		htmlStr += '<thead>';
		htmlStr += '<tr>';
		for(var fi = 0; fi< data.configFields.length; fi++){
			var field = data.configFields[fi];
			htmlStr += '<th>';
			htmlStr += field.field_title_cn;
			htmlStr += '</th>';
		}
		htmlStr += '</tr>';
		htmlStr += '</thead>';
		htmlStr += '<tbody>';
		
		for(var i = 0; i< data.dataList.length; i++){
			var dr =  data.dataList[i];
			htmlStr += "<tr data='"+JSON.stringify(dr)+"'>";
			for(var fi = 0; fi< data.configFields.length; fi++){
				var field = data.configFields[fi];
				htmlStr += '<td>';
				htmlStr += dr[field.field_name];
				htmlStr += '';
				htmlStr += '';
				htmlStr += '';
				htmlStr += '</td>';
			}
			htmlStr += '</tr>';
	 	}
		htmlStr += '</tbody>';
		htmlStr += '</table>';
	} else {
	 	htmlStr += '<ul class="modelUl">';
	 	var dr = null;
	 	for(var i = 0; i< data.dataList.length; i++){
			  dr =  data.dataList[i];
			  htmlStr += "<li data = '"+JSON.stringify(dr)+"'>";
			  htmlStr += '<div>'+dr[data.configFields[0].field_name]+'</div>';
			  htmlStr += '</li>';
	 	}
		htmlStr += '</ul>';
	}
	$("#modelContent").append(htmlStr);
	$("#modelContent").attr('brand', data.brand);
	$("#modelContent").attr('layer_id', data.layer_id);
}

function addPanel(title){
	//var tab = $('#systemPartsContainer').getTab(title);
	var tab = $('#systemPartsContainer').tabs('getTab',title);
	if(!tab){
		$('#systemPartsContainer').tabs('add',{
			id: title, title: title,
			content: '<div style="padding:10px">Content</div>',
			closable: true
		});
	} else {
		//$('#systemPartsContainer').select(title);
		$('#systemPartsContainer').tabs('select',title);
	}
}

$(".oNav div.on").live("click",function(){
	var layer_id = parseInt($(this).attr("layer_id"));
	
	if(layer_id){
		$("#modelContent").removeClass("hidden");
		$("#modelContent").addClass("show");
		var brand = ocatalogDataObj.currentBrand;
		
		var destroy = false;
		$("#modelLayerNav div.on").each(function(index,element){
			if($(this).attr("layer_id") == layer_id){
				destroy = true;
			} else if(destroy){
				$(this).removeClass("on");
				$('b',this).text('');
			}
		});
		

		$("#modelContent").attr('brand', brand);
		$("#modelContent").attr('layer_id', layer_id);
		 
		var tmpdata = ocatalogDataObj[brand].layersData[layer_id];
		tmpdata.brand = brand;
		modelLayerHtml(tmpdata);
	} else {
		$("#modelContent").removeClass("show");
		$("#modelContent").addClass("hidden");
		
		$("#brandListDiv").removeClass("hidden");
		$("#brandListDiv").addClass("show");

		$("#modelLayerNav").html('');
	}
	
	
});

</script>


