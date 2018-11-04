<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
		<style type="text/css">
			
			.box{
			margin:auto;
			width: 400px;
			border:1px solid black;
			padding:30px;
			}
			input[type="text"]{
			margin-bottom: 20px;
			width:210px;
			height:30px;
			}
			input[type="password"]{
			margin-bottom: 20px;
			width:210px;
			height:30px;
			}
			p{
				text-align: center;
			}
		</style>
	</head>
	<body>
		<div class="box">
			<form action="Login_Controller"  method="post">
				
				<h1>Login</h1>
				
				<input type="text" name="name" placeholder="Name"/>
				<br> 
				<input type="password" name="pass" placeholder="Password"/>
				<br> 
				<input type="submit" value="login"/>
				<br>
						  
			</form>
		</div>
		<p>Forgot your password? <u style="color:#f1c40f;">Click Here!</u></p>
		<!--  <script type="text/javascript">
			var status=<%=request.getAttribute("response")%>;
			if(status.equals("1"))
				alert("wrong name or password");
		</script>-->
	</body>
</html>