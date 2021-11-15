<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String User=request.getParameter("User").toString();
	String OTP=request.getParameter("OTP").toString();
	try 
	{
		String Ht="jdbc:sqlserver://localhost\\VAIBHAV:1433;databaseName=forprachuu";
	    String UN="sa";
	    String UP="vahbiav";
	    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	    Connection con= DriverManager.getConnection(Ht,UN,UP);
	    PreparedStatement p=con.prepareStatement("select * from UserDetails where Username=?");
	    p.setString(1,User);
	    ResultSet rs= p.executeQuery();
	    if (rs.next()) 
	    {
	    	String emailadd=rs.getString(3);
	    	Properties props = new Properties();    
	    	props.put("mail.smtp.host", "smtp.gmail.com");    
	    	props.put("mail.smtp.socketFactory.port", "465");    
	    	props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");    
	    	props.put("mail.smtp.auth", "true");    
	    	props.put("mail.smtp.port", "465");   
	    	Session sess = Session.getInstance(props,new javax.mail.Authenticator(){protected PasswordAuthentication getPasswordAuthentication() { return new PasswordAuthentication("YourEmail","YourPassword");}});        
	    	try {
	    		MimeMessage message = new MimeMessage(sess);    
	            message.addRecipient(Message.RecipientType.TO,new InternetAddress(emailadd));    
	            message.setSubject("Chef Password Reset");    
	            message.setText("Your OTP: "+OTP+"\nPlease do not share this OTP with anyone.");    
	            Transport.send(message);
	    	 	out.println("EmailSent");
	    	} catch (MessagingException e) {out.println(e);System.out.println(e);}    		
	    }
	} 
	catch (Exception e) 
	{
		out.print("Oops!! Some Error occured please try again.!");
	}
	
%>
</body>
</html>