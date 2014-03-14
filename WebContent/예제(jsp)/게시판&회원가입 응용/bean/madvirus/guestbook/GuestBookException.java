package madvirus.guestbook;

public class GuestBookException extends Exception
{
	public GuestBookException(String msg){
		super(msg);
	}
	public GuestBookException(String msg, Throwable ex){
		super(msg, ex);
	}
}