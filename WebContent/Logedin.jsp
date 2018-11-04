<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<%
	String id = request.getParameter("userid");
	String driver = "com.mysql.jdbc.Driver";
	String url="jdbc:mysql://Localhost:3306/rfid?useSSL=false";
	String userid = "root";
	String password = "arasan1963";
	try {
	Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
	e.printStackTrace();
	}
	Connection connection = null;
	Statement statement= null;
	Statement statement1= null;
	ResultSet resultSet= null;
	ResultSet resultSet1= null;
	%>
<!DOCTYPE html>
<html>
	<head>
		<style>
			header{
				height:60px;
				border-bottom: 1px solid #ddd;
				margin-bottom:20px;
			}
			#list {
			    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
			    border-collapse: collapse;
			    width: 100%;
			}
			
			#list td, #list th {
			    border: 1px solid #ddd;
			    padding: 8px;
			}
			
			#list tr:nth-child(even){background-color: #f2f2f2;}
			
			#list tr:hover {background-color: #ddd;}
			
			#list th {
			    padding-top: 12px;
			    padding-bottom: 12px;
			    text-align: left;
			    background-color: #00007f;
			    color: white;
			}
			label{
				margin-left:30px;
			}
			form{
				margin-bottom:50px;
			}
		</style>
	</head>
	<body>
		<header>
			
		</header>
		<section>
			<form action = "Logedin.jsp" method = "GET">
				<label >Date:</label>
		        <input type="date" id=" " name="date" required />
				<label >From:</label>
		        <input type="time" id=" " name="from" step="1" required />
		        <label>To:</label>
		        <input type="time"  name="to" step="1"required />
				<label>Choose Filter:</label>
				<select name="selectResult" id="mySelect" onchange="myFunction()">
					<option  value="department">department</option>
					<option  value="class">class</option>
				</select>
				<label id="optionlabel"></label>
				<input type="text"  name="constraint" required />
				<input type="submit" value="Submit"/>
			</form>
			<script>
				function myFunction() 
				{
				    var myOption = document.getElementById("mySelect").value;
				    document.getElementById("optionlabel").innerHTML = "Enter "+myOption;
				}
			</script>
			
			<table id="list">
				<tr>
					<th>Register number</th>
					<th>Name</th>
					<th>Date</th>
					<th>Check In Time</th>
					<th>Check out Time</th>
				</tr>
				<%
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
					String Regno,Result=null;
					
					String date=request.getParameter("date");
					String from=request.getParameter("from");
					String to=request.getParameter("to");
					//String option="class";
					String option=request.getParameter("selectResult");
					String constraint=request.getParameter("constraint");
					 
					
				
					try
					{
					connection = DriverManager.getConnection(url, userid, password);
					statement=connection.createStatement();
					statement1=connection.createStatement();
					String sql1 ="select * from rfid.attendance,rfid.students where (check_date='"+date+"' AND check_in >= '"+from+"' AND check_out <= '"+to+"' AND Idno=regno AND (class='"+constraint+"' OR department='"+constraint+"'));";
					resultSet1= statement.executeQuery(sql1);
					
					
					while(resultSet1.next())
					{
				 %>
						<tr>
							<td><%=resultSet1.getString("regno") %></td>
							
				<%
						Regno=resultSet1.getString("regno");
						int Id=Integer.parseInt(Regno);
						String sql ="select name from rfid.students where Idno="+Id+";";
						resultSet = statement1.executeQuery(sql);
						while(resultSet.next()) 
						{
							Result=resultSet.getString("name");
						}
				%>
							<td><%=Result %></td>
							<td><%=resultSet1.getString("check_date") %></td>
							<td><%=resultSet1.getString("check_in") %></td>
							<td><%=resultSet1.getString("check_out") %></td>
						</tr>
				<%
					}
					connection.close();
					} catch (Exception e) {
					e.printStackTrace();
					}
					
				%>
			</table>
		</section>
	</body>
</html>