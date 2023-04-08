package model;

public class InvalidICException extends Exception {

    public InvalidICException() {
        super("Invalid IC Exception.");
    }

    public InvalidICException(String msg) {
        super(msg);
    }
}
