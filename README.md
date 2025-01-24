# Version
Apache NetBeans IDE 12.6
JDK 1.8
GlassFish Server 6

# Installation 
1. Download the folder
2. Add JAR `activation-1.1.jar`
3. Create database 
   	Database Name: cinemadb
	User Name: nbuser
	Password: nbuser
4. Run the SQL script
5. Run the project starting from login.jsp

# Login Credentials
|   Role   |         Account         |    Password    |  
|----------|-------------------------|----------------|  
| Admin    | tanjeremy0930@gmail.com | Tjeremy900930  |  
| Staff    | mingxing0124@gmail.com  | Mxing870124    |  
| Customer | siti0816@gmail.com      | Siti900816     |  

# Password Reference as password has been hashed 
|         Account         |    Password    |
|-------------------------|----------------|  
| tanjeremy0930@gmail.com | Tjeremy900930  |
| peiling0818@gmail.com   | Pling790818    |
| mingxing0124@gmail.com  | Mxing870124    |
| kokming1234@gmail.com   | KMing880620    |
| cheelin0410@gmail.com   | CLin860410     |
| siti0816@gmail.com      | Siti900816     |
| farah0125@gmail.com     | Frh900125      |
| azizul0327@gmail.com    | Azz850327      |
| kerming0221@gmail.com   | KerMng820221   |
| yongwei0213@gmail.com   | Yweii920213    |
| angelyn1119@gmail.com   | Anglyn901119   |
| weiwei0925@gmail.com    | Wwe900925      |
| shinyii0102@gmail.com   | Azz850102      |
| mike0220@gmail.com      | KerMng820220   |
| syafiq0812@gmail.com    | Abdulah920812  |

# Role Based Access Control
|                 Module                 |  Role  |    Permission    |
|----------------------------------------|--------|------------------|
| Staff                                  | Admin  | Add              |
|                                        |        | View ALL         |
|                                        |        | Update           |
|                                        |        | Delete           |
|                                        | Staff  | View PERSONAL    |
|                                        |        | Update PERSONAL  |
| Customer                               | Admin, Staff | View ALL   |
| Role                                   | Admin  | Add              |
|                                        |        | View ALL         |
|                                        |        | Update           |
|                                        |        | Delete           |
|                                        | Staff  | -                |
| Actor                                  | Admin  | Add              |
|                                        |        | View ALL         |
|                                        |        | Update           |
|                                        |        | Delete           |
|                                        | Staff  | Add              |
|                                        |        | View ALL         |
| Movie                                  | Admin  | Add              |
|                                        |        | View ALL         |
|                                        |        | Update           |
|                                        |        | Delete           |
|                                        | Staff  | Add              |
|                                        |        | View ALL         |
| Movie Schedule                         | Admin  | Add              |
|                                        |        | View ALL         |
|                                        |        | Update           |
|                                        |        | Delete           |
|                                        | Staff  | Add              |
|                                        |        | View ALL         |
| Theatre                                | Admin  | Add              |
|                                        |        | View ALL         |
|                                        |        | Update           |
|                                        |        | Delete           |
|                                        | Staff  | Add              |
|                                        |        | View ALL         |
| Food & Beverages Category              | Admin  | Add              |
|                                        |        | View ALL         |
|                                        |        | Update           |
|                                        |        | Delete           |
|                                        | Staff  | Add              |
|                                        |        | View ALL         |
| Food & Beverages                       | Admin  | Add              |
|                                        |        | View ALL         |
|                                        |        | Update           |
|                                        |        | Delete           |
|                                        | Staff  | Add              |
|                                        |        | View ALL         |
| Booking                                | Admin  | View ALL         |
|                                        |        | Update           |
|                                        | Staff  | View ALL         |
| Food & Beverages Order Delivery        | Admin, Staff | View ALL         |
|                                        |        | Update           |
| Promotion                              | Admin, Staff | Add              |
|                                        |        | Retrieve         |
|                                        |        | Update           |
|                                        |        | Update Status    |
| Payment                                | Admin, Staff | View ALL         |
| Question                               | Admin  | Add              |
|                                        |        | View ALL         |
|                                        |        | Update           |
|                                        |        | Delete           |
|                                        | Staff  | Add              |
|                                        |        | View ALL         |
| Top Favourite Food & Beverages Report, Service Rating Report   | Admin, Staff| View                 |
| Daily Sales Report, Top List of Highest Grossing Report                    | Admin  | View             |
|                                        | Staff  | -                |
	
	





	
