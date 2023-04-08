package model;

import java.util.ArrayList;

public class FavItem {
    
    private String favItemID;
    private Fnb fnb;
    private Account account;

    public FavItem() {
    }

    public FavItem(String favItemID) {
        this.favItemID = favItemID;
    }

    public FavItem(String favItemID, Fnb fnb, Account account) {
        this.favItemID = favItemID;
        this.fnb = fnb;
        this.account = account;
    }
    
    public String getFavItemID() {
        return favItemID;
    }
    
    public void setFavItemID(String favItemID) {
        this.favItemID = favItemID;
    }

    public Fnb getFnb() {
        return fnb;
    }
    
    public void setFnb(Fnb fnb) {
        this.fnb = fnb;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }
    
    public static String generateFavItemID() throws Exception{
        FavItemDA favItemDA = new FavItemDA();
        ArrayList<FavItem> favItemList = favItemDA.getRecord();
        String favItemID;
        
        if(favItemList.size() > 0) {
            String lastFavItemID = favItemList.get(favItemList.size() - 1).getFavItemID(); 
            int favItemIDInt = Integer.parseInt(lastFavItemID.substring(2)) + 1;
            favItemID = "FI" + String.format("%04d", favItemIDInt);
        } else {
            favItemID = "FI0001";
        }
        
        return favItemID;
    }
    
    public static void validateStockAvailability() throws Exception{
        FavItemDA favItemDA = new FavItemDA();
        ArrayList<String> fnbIDList = favItemDA.getFnbID();
        
        FnbDA fnbDA = new FnbDA();
        ArrayList<Fnb> fnbList = fnbDA.getRecord();
        
        for(String fnbID : fnbIDList) {
            for(Fnb fnb : fnbList) {
                if(fnbID.equals(fnb.getFnbID())) {
                    if(!fnb.isActive()) {
                        favItemDA.deleteFnbID(fnbID);
                    }
                }
            }
        }
        
    }
    
}
