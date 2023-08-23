<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<style>
 
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');

#container{
   width: 100%;
   margin:  0px auto;
   text-align:center;
   border: 0px solid #bcbcbc;
}

#header{
   width: 100%;
   padding:5px;
   height: 150px;
  
   color: #003d0a;
   border: 0px solid #ffffff;
   background-color: #FEF7DD;
   font-family: 'Noto Sans KR', sans-serif;
}

#header a{
	text-decoration: none;
}
#sidebar-left{
	width:15%;
	height:700px;
	padding:5px;
	margin-right:5px;
	margin-bottom:5px;
	float: left;
	color: #003d0a;
	border: 0px solid #003d0a;
	background-color: 	#ffc6c6;
	font-size:10px;
}



#content{
   width: 100%;
   
   /*padding:5px;*/
   margin-right:5px;
   float: left;
   border: 0px solid #bcbcbc;
   background-color: #ffffff;
   background-size: 30% 0;
}
#footer{
	clear:both;
	padding:1px;
	border: 0px solid #e7e7e7;
	background-color: #eee;
	padding-top: 0px;
}
</style>

<title><tiles:insertAttribute name="title" /></title>
</head>
<body>

<div id="container">
	<div id="header">
		<tiles:insertAttribute name="header"/>
	</div>
	
	
	<div id="content">
		<tiles:insertAttribute name="body"/>
	</div>
	
	<div id="footer">
		<tiles:insertAttribute name="footer"/>
	</div>
</div>

</body>
</html>