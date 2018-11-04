package controller.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class loginController
 */
@WebServlet("/loginController")
public class loginController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	private String Name,Pass;
	protected String uid;
	
	protected String url="jdbc:mysql://Localhost:3306/smart_shopping?useSSL=false";
	protected String user="root";
	protected String password="yuva";
	
	protected Connection con = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Name=request.getParameter("name");
		Pass=request.getParameter("pass");
		boolean found=checkLogin();
		
		if(found==true)
		{
			Cookie ck=new Cookie("id",uid);
			response.addCookie(ck);
			getServletContext().getRequestDispatcher("/mainPage.jsp").forward(request, response);
		}
		else
		{
			getServletContext().getRequestDispatcher("/notfound.jsp").forward(request, response);
			
		}
				
	}
	
	protected boolean checkLogin()
	{ 
		boolean flag=false;
		String name = null,pass=null;
		try 
		{
			Class.forName("com.mysql.jdbc.Driver"); 
			//1.establish connection
			Connection connect=DriverManager.getConnection(url,user,password);
		
			//2.create a sql query
				
				Statement mystmt=connect.createStatement();
				
			//3.execute sql query
				
				ResultSet user_details=mystmt.executeQuery("select * from smart_shopping.users ;");
				
			//4.process the result set			
				
				while (user_details.next()) 
				{	
					name=user_details.getString("name");
					pass=user_details.getString("password");
					if(name.equals(Name) && pass.equals(Pass))
					{
						flag=true;
						uid=user_details.getString("uid");
						break;
					}
				}
				
		} catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		
		
		return flag;
	}

}
