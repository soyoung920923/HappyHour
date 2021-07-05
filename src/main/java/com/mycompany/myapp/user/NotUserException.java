package com.mycompany.myapp.user;


public class NotUserException extends Exception {
	
	public NotUserException() {
		super("NotUserException");
	}
	public NotUserException(String msg) {
		super(msg);
	}

}

