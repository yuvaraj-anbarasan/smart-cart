package controller.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class orderController
 */
@WebServlet("/orderController")
public class orderController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	private int uid,pid=0,logoutStatus=0;
	int discount_price;
	
	protected String url="jdbc:mysql://Localhost:3306/smart_shopping?useSSL=false";
	protected String user="root";
	protected String password="yuva";
	Statement statement= null;
	Statement product= null;
	ResultSet products=null;
	Statement statement1= null;
	ResultSet p= null;
	ResultSet Count= null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public orderController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		uid=Integer.parseInt(request.getParameter("name"));
		pid=Integer.parseInt(request.getParameter("pass"));
		logoutStatus=Integer.parseInt(request.getParameter("status"));
		if(logoutStatus!=1 && pid!=0)
		{
			try 
			{
				Class.forName("com.mysql.jdbc.Driver"); 
				//1.establish connection
				Connection connect=DriverManager.getConnection(url,user,password);
			
				statement=connect.createStatement();
				String sql1 ="select * from smart_shopping.products where pid="+pid+";";
				p= statement.executeQuery(sql1);
				
				while(p.next())
				{
					int price=Integer.parseInt(p.getString("price"));
					int dis=Integer.parseInt(p.getString("discount"));
					float offer=dis/100;
					float discount=price*offer;
					discount_price=price-((int)discount);
				}
				Statement stmt = connect.createStatement();
			      
			      String sql = "INSERT INTO smart_shopping.cart " +
			                   "VALUES ("+uid+","+pid+","+discount_price+")";
			      stmt.executeUpdate(sql);
					
			      /*product=connect.createStatement();
					String product_details="select * from smart_shopping.products where pid="+pid+";";
					products= product.executeQuery(product_details);
					while(products.next())
					{
						String pimg=products.getString("pimg");
						String pname=products.getString("pname");
						int price=Integer.parseInt(products.getString("price"));
						int dis=Integer.parseInt(products.getString("discount"));
						float offer=dis/100;
						float discount=price*offer;
						int discount_price=price-((int)discount);*/
			      
			} catch (Exception ex) 
			{
				ex.printStackTrace();
			}
		}
		else if(logoutStatus==1)
		{
			response.setContentType("text/html");  
		    PrintWriter out = response.getWriter();  
			try {
				Class.forName("com.mysql.jdbc.Driver");
			
			//1.establish connection
			Connection connect=DriverManager.getConnection(url,user,password);
		
			Statement stmt = connect.createStatement();
			Statement stmt1 = connect.createStatement();
			Statement stmt2 = connect.createStatement();
			Statement stmt3 = connect.createStatement();
			/**************finding total ************************/
			
			statement=connect.createStatement();
			String sql1 ="SELECT SUM(total) from smart_shopping.cart where uid="+uid+"; ";
			p= stmt.executeQuery(sql1);
			
			int total = 0;
			out.print(total+"++++++++++++++");
			while(p.next())
			{
				total=p.getInt(1);
				out.print(total);  
				//System.out.println(total);
			}
			
			/***********************************************************/
			
			/**************finding Itemcount ************************/
			
			statement=connect.createStatement();
			String sql3 ="SELECT COUNT(*) from smart_shopping.cart where uid="+uid+"; ";
			Count= stmt.executeQuery(sql3);
			
			int count = 0;
			while(Count.next())
			{
				count=Count.getInt(1);
				//System.out.println(total);
			}
			
			/***********************************************************/
			
			/********   Calculating date   **************/
		      Date date = new Date();
		      String pattern = "MMMMM dd,yyyy hh:mm:ss a";
		      SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		      // display time and date
		      String d = simpleDateFormat.format(date);
		      /***********************************************/
		      
		      String sql = "INSERT INTO smart_shopping.orders " +
		                   "VALUES ("+uid+","+count+","+total+",'"+d+"')";
		      
		      
		      String sql2 = "delete from smart_shopping.cart where uid="+uid+";";
		      
		      stmt1.executeUpdate(sql);
		      stmt2.executeUpdate(sql2);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
