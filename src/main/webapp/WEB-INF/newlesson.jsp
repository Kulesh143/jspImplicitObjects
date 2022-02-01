JSP Implicit Objects

Objects made by the web container in the _jsp service method at JSP runtime are JSP Implicit Objects. These are
method local variables not found in the JSP file but we code using them.
There are 9 jsp implicit objects. These objects are created by the web container that are available to all the jsp pages.

The available implicit objects are out, request, config, session, application etc.

Object      Type
out	        JspWriter
request	    HttpServletRequest
response    HttpServletResponse
config	    ServletConfig
application ServletContext
session	    HttpSession
pageContext PageContext
page	    Object
exception	Throwable

1) JSP out implicit object
PrintWriter out=response.getWriter();
But in JSP, you don't need to write this code.

Example of out implicit object
In this example we are simply displaying date and time.

index.jsp
<html>
<body>
<% out.print("Today is:"+java.util.Calendar.getInstance().getTime()); %>
</body>
</html>

2)JSP request implicit object
The JSP request is an implicit object of type HttpServletRequest i.e.
created for each jsp request by the web container. It can be used to get request
information such as parameter, header information, remote address, server name,
server port, content type, character encoding etc.

It can also be used to set, get and remove attributes from the jsp request scope.

<form action="welcome.jsp">
    <input type="text" name="uname">
    <input type="submit" value="go"><br/>
</form>
welcome.jsp
<%
    String name=request.getParameter("uname");
    out.print("welcome "+name);
%>
<%
    RequestDispatcher rd=request.getRequestDispatcher("/WEB-INF/welcome.jsp");
    rd.forward(request,response);
%>
3)JSP response implicit object
In JSP, response is an implicit object of type HttpServletResponse.
The instance of HttpServletResponse is created by the web container for each jsp request.

It can be used to add or manipulate response such as redirect response to another resource,
send error etc.

index.html
<form action="welcome.jsp">
    <input type="text" name="uname">
    <input type="submit" value="go"><br/>
</form>
welcome.jsp
<%
    response.sendRedirect("http://www.google.com");
%>

4) JSP config implicit object
In JSP, config is an implicit object of type ServletConfig.
This object can be used to get initialization parameter for
a particular JSP page. The config object is created by the web container for each jsp page.

index.html
<form action="welcome">
    <input type="text" name="uname">
    <input type="submit" value="go"><br/>
</form>
web.xml file
<web-app>

    <servlet>
        <servlet-name>sonoojaiswal</servlet-name>
        <jsp-file>/welcome.jsp</jsp-file>

        <init-param>
            <param-name>dname</param-name>
            <param-value>sun.jdbc.odbc.JdbcOdbcDriver</param-value>
        </init-param>

    </servlet>

    <servlet-mapping>
        <servlet-name>sonoojaiswal</servlet-name>
        <url-pattern>/welcome</url-pattern>
    </servlet-mapping>

</web-app>
welcome.jsp
<%
    out.print("Welcome "+request.getParameter("uname"));

    String driver=config.getInitParameter("dname");
    out.print("driver name is="+driver);
%>
<% config.getServletContext().setAttribute("name","Alex Rider");
    out.print(config.getServletContext().getAttribute("name"));%>
5) JSP application implicit object
In JSP, application is an implicit object of type ServletContext.

The instance of ServletContext is created only once by the web container when application or project is deployed on the server.

This object can be used to get initialization parameter from configuaration file (web.xml).
It can also be used to get, set or remove attribute from the application scope.

index.html
<form action="welcome">
    <input type="text" name="uname">
    <input type="submit" value="go"><br/>
</form>
web.xml file
<web-app>

    <servlet>
        <servlet-name>sonoojaiswal</servlet-name>
        <jsp-file>/welcome.jsp</jsp-file>
    </servlet>

    <servlet-mapping>
        <servlet-name>sonoojaiswal</servlet-name>
        <url-pattern>/welcome</url-pattern>
    </servlet-mapping>

    <context-param>
        <param-name>dname</param-name>
        <param-value>sun.jdbc.odbc.JdbcOdbcDriver</param-value>
    </context-param>

</web-app>
welcome.jsp
<%

    out.print("Welcome "+request.getParameter("uname"));

    String driver=application.getInitParameter("dname");
    out.print("driver name is="+driver);
    application.setAttribute("dname","Kulesh");
    String driver= (String) application.getAttribute("dname");
    out.print("driver name is="+driver);
%>

6) session implicit object
In JSP, session is an implicit object of type HttpSession.The Java developer
can use this object to set,get or remove attribute or to get session information

<html>
<body>
<%

    String name=request.getParameter("uname");
    out.print("Welcome "+name);

    session.setAttribute("user",name);

    <a href="second.jsp">second jsp page</a>

%>
</body>
</html>
second.jsp
<html>
<body>
<%
    session.setAttribute("user",name);
    String name=(String)session.getAttribute("user");
    out.print("Hello "+name);

%>
</body>
</html>

7) pageContext implicit object
In JSP, pageContext is an implicit object of type PageContext class.
The pageContext object can be used to set,get or remove attribute from one of the following scopes:
page
request
session
application
In JSP, page scope is the default scope.

<html>
<body>
<%

    String name=request.getParameter("uname");
    out.print("Welcome "+name);

    pageContext.setAttribute("user",name,PageContext.SESSION_SCOPE);

    <a href="second.jsp">second jsp page</a>

%>
</body>
</html>
second.jsp
<html>
<body>
<%
    pageContext.setAttribute("user","name Kulesh",PageContext.SESSION_SCOPE);
    String name=(String)pageContext.getAttribute("user",PageContext.SESSION_SCOPE);
    out.print("Hello "+name);

%>
</body>
</html>

8) page implicit object:
In JSP, page is an implicit object of type Object class.This object is assigned to the reference of auto generated servlet class. It is written as:
Object page=this;
For using this object it must be cast to Servlet type.For example:

<% (HttpServlet)page.log("message"); %>
Since, it is of type Object it is less used because you can use this object directly in jsp.For example:
<% this.log("message"); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

9) exception implicit object
In JSP, exception is an implicit object of type java.lang.Throwable class. This object can be used to print the exception.
But it can only be used in error pages.It is better to learn it after page directive. Let's see a simple example:

<%@ page isErrorPage="true" %>
<html>
<body>

Sorry following exception occured:<%= exception %>

</body>
</html>
<%
    out.print("Error Message : ");
    out.print(exception.getMessage());
%>