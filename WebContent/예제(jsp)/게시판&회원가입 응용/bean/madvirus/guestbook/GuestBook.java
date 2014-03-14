/*	[GuestBookManager.java]	*/
package madvirus.guestbook;

import java.sql.Timestamp;

public class GuestBook {
	private int       id;
	private String    name;
	private String    password;
	private String    email;
	private String    content;
	private Timestamp register;
	private String    mode;

	public  void      setId(int id)                   {	this.id       = id;	}
	public  void      setName(String name)            {	this.name     = name.trim();	}
	public  void      setPassword(String password)    {	this.password = password.trim();	}
	public  void      setEmail(String email)          {	this.email    = email.trim();	}
	public  void      setContent(String content)      {	this.content  = content.trim();	}
	public  void      setRegister(Timestamp register) {	this.register = register;	}
	public  void      setMode(String mode)            {	this.mode     = mode.trim();	}

	public  int       getId()                         {	return id;	}
	public  String    getName()                       {	return name;	}
	public  String    getPassword()                   {	return password;	}
	public  String    getEmail()                      {	return email;	}
	public  String    getContent()                    {	return content;	}
	public  Timestamp getRegister()                   {	return register;	}
	public  String    getMode()                       {	return mode;	}
}
