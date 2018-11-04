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
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="author" content="Yuvaraj Anbarasan">
	<title>Welcome|Smart</title>
	<link rel="stylesheet" href="./css/style.css">
	<style>
		footer
		{
			padding:20px;
			margin-top: 20px;
			color: white;
			background-color: #aaaeaf;
			text-align: center;
		}
	</style>
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

	<section id="showcase">
		<div id="showcase_img">
		<img src="./images/MainPage/slides/img1.jpg">
		</div>
		<button class="prev" onclick="prevImg()"> < </button>
		<button class="next" onclick="nextImg()"> > </button>
	</section>
	<script type="text/javascript">
		var slider_content=document.getElementById("showcase_img");
		var imgs=["img1","img2","img3","img4"];

		var i=imgs.length;
		function nextImg(){
			if(i<imgs.length){
				i=i+1;
			}else{
				i=1;
			}
			slider_content.innerHTML='<img src="./images/MainPage/slides/'+imgs[i-1]+'.jpg" >';
		}
		function prevImg(){
			if(i<imgs.length+1 && i>1 ){
				i=i-1;
			}else{
				i=imgs.length;
			}
			slider_content.innerHTML='<img src="./images/MainPage/slides/'+imgs[i-1]+'.jpg" >';
		}
	</script>
	

	<section id="boxes" >
		<div class="container">
			<h1>Special Offers</h1>
			<div>
			<img src="./images/offer_design.png" width="350px">
			</div>
			<%
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
						product=connection.createStatement();
						String product_details="select * from smart_shopping.products where discount >= 20;";
						products= product.executeQuery(product_details);
						while(products.next())
						{
							String pimg=products.getString("pimg");
							String pname=products.getString("pname");
							int price=Integer.parseInt(products.getString("price"));
							int dis=Integer.parseInt(products.getString("discount"));
							float offer=((float)dis)/100;
							float discount=price*offer;
							float discount_price=price-(discount);
							
			%>
				<div class="box">
					<div>
						<img src="<%=pimg%>">
					</div>
					<h3><%=pname%></h3>
					<label>MRP:<del><%=price%></del></label><label>Rs:<%=discount_price%></label><label id="offer"><%=dis%>% Off</label>
					<button>Add to remaider</button>
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
		<p>Smart</p>
	</footer>
</body>
</html>