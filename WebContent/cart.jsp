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
	Statement product= null;
	ResultSet pid= null;
	ResultSet products=null;
	int Pid;
%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="./css/style.css">
		<link rel="stylesheet" type="text/css" href="./css/Dropdown_style.css">
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
			<div class="cart_container" align="center">
			<%
					int flag=0;
					String Id="ssad";
			 		String UID=null;
					float bag_total=0,bag_discount=0;
					float tax=18;
					float Grand_total;
					Cookie ck[]=request.getCookies(); 
					 if(ck!=null){ 
						 UID=ck[0].getValue(); 
			        }
					try
					{
					connection = DriverManager.getConnection(url, userid, password);
					statement=connection.createStatement();
					product=connection.createStatement();
					String sql ="select * from smart_shopping.cart where uid="+UID+";";
					pid= statement.executeQuery(sql);
					
					while(pid.next())
					{
						Pid=Integer.parseInt(pid.getString("pid"));
						String product_details="select * from smart_shopping.products where pid="+Pid+";";
						products= product.executeQuery(product_details);
						while(products.next())
						{
							flag=1;
							String pimg=products.getString("pimg");
							String pname=products.getString("pname");
							float price=Float.valueOf(products.getString("price"));
							float dis=Integer.parseInt(products.getString("discount"));
							float offer=dis/100;
							float discount=price*offer;
							float discount_price=price-(discount);
							bag_total+=discount_price;
							bag_discount+=discount;
							
			%>
				<div class="product">
					<img class="img" src="<%=pimg%>"/>
					<p><%=pname%></p>
					<label><%=price%></label>
				</div>
			<%
						}
					}
					connection.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					
					Grand_total=bag_total-(bag_total*(tax/100));
					if(flag==1)
					{
					
			%>
				<div class="total">
					<table>
						<tr>
							<td>Bag total</td>
							<td> <%= bag_total%></td>
						</tr>
						<tr>
							<td>Bag discount</td>
							<td><%=bag_discount%></td>
						</tr>
						<tr>
							<td>Tax</td>
							<td><%= tax%></td>
						</tr>
						<tr  id="last_row">
							<td>Grand total</td>
							<td><%= Grand_total%></td>
						</tr>
					</table>
				</div>
			<%
					}
				else if(flag!=1)
				{
			%>
				<div class="construction">
					<img src="./images/empty-cart.jpg">
				</div>
			<%
				}
			%>
			</div>
		</section>
		
		<footer>
			<p>Smart</p>
		</footer>
	</body>
</html>