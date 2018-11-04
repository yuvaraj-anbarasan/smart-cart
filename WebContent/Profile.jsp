<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


<%
	String id = request.getParameter("userid");
	String driver = "com.mysql.jdbc.Driver";
	String url="jdbc:mysql://Localhost:3306/smart_shopping?useSSL=false";
	String userid = "root";
	String password = "yuva";
	try {
	Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
	e.printStackTrace();
	}
	Connection connection = null;
	Statement statement= null;
	ResultSet details= null;
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Applesoft nourishes your language">
	<meta name="keywords" content="">
	<meta name="author" content="Yuvaraj Anbarasan">
	<title>Welcome</title>
	<link rel="stylesheet" href="./css/style.css">
</head>
<body>
	<header>
		<div class="container">
			<div id="branding">
				<h1>Smart</h1>
			</div>
			<nav>
				<ul>
					<li><a class="active" href="mainPage.jsp">Home</a></li>
					<li><a href="about.html">About</a></li>
					<li><a href="">Services</a></li>
					<li>
							<div class="dropdown">
							  <button class="dropbtn"><img src="./images/user.png" width="20px" height="20px">
							  </button>
							  <div class="dropdown-content">
							    <a href="Profile.jsp"><img src="./images/edit-profile.png" width="20px" height="20px"><span>Profile details</span></a>
							    <a href="receipts.jsp"><img src="./images/receipts.png" width="20px" height="20px"><span>Receipts</span></a>
							    <a href="remainder.html"><img src="./images/remainder.png" width="20px" height="20px"><span>Remainder</span></a>
							    <a href="Logout_Controller"><span id="last-span">Logout</span></a>
							  </div>
							</div>
					</li>
					<li>
						<a href="cart.jsp"><img src="./images/Cart.png" width="20px" height="20px"></a>
					</li>
				</ul>
			</nav>
		</div>
	</header>

	<section>
		<div class="container">
		<%
					
			 		String UID=null;
					Cookie ck[]=request.getCookies(); 
					 if(ck!=null){ 
						 UID=ck[0].getValue(); 
			        }
					try
					{
					connection = DriverManager.getConnection(url, userid, password);
					statement=connection.createStatement();
					String sql ="select * from smart_shopping.users where uid="+UID+";";
					details= statement.executeQuery(sql);
					
					while(details.next())
					{
						String name=details.getString("name");
						String address=details.getString("address");
						String email=details.getString("email");
						String mobNo=details.getString("mobno");	
							
		%>
			<h2>Your Details</h2>
			<div class="profile">
				<div>
					<h4><%= name%></h4>
					<p><%= address%></p>
					<label>Email Id:<%= email%></label>
					<br>
					<label>Phone no:<%= mobNo%></label>
				</div>
			</div>
		<%
								
				}
				connection.close();
				} catch (Exception e) {
				e.printStackTrace();
				}
		%>
		
		</div>
	</section>

	<footer>
		<p>Applesoft</p>
	</footer>
</body>
</html>