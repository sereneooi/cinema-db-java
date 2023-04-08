<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*;"%>
<%@page import="model.Movie, model.MovieDA"%>
<%@page import="model.Language, model.LanguageDA" %>
<%@page import="model.MovieType, model.MovieTypeDA" %>
<%@page import="model.MovieStatus, model.MovieStatusDA" %>
<%@page import="model.MovieRestriction, model.MovieRestrictionDA" %>
<%@page import="model.Actor, model.ActorDA" %>
<%@page import="java.util.List, java.util.ArrayList" %>
<jsp:useBean id="currentUser" scope="session" class="model.Account"/>

<!DOCTYPE html>
<html>
    <head>
        <title>CC Cinema</title>
        <link href="logo.png" rel="icon" type="image/png"/>
        <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <style>
            html{
    background-image: url(background.png);

        }
        
        @font-face {
        font-family: 'mahelisa';
        src: url(mahelisa.ttf);
        }

        body {
            background-color: #a1a1a1;
            margin: 0 auto;
            width: 100%;
            max-width: 1020px;
            min-width: 800px;
            z-index: -1;
        }

        h1{
            color: rgb(153, 102, 255);
            font-size: 20px;
            font-family: 'Times New Roman', Times, serif;
            margin-left: 30px;
        }

        a{
            text-decoration: none;
            color: rgb(153, 102, 255);
            font-size: 20px;
            font-family: 'Times New Roman', Times, serif;
            text-align: center;
            display: inline-block;
        }

        a:active{
            color: rgb(179, 179, 255);
        }
        
        .contentContainer1{
                background-color: #4c4359;
                padding-left: 10px;
                padding-right: 30px;
                height: 1450px;
                margin-top: 20px;
                margin-bottom: 20px;
                border-radius: 25px;
        }
        
        .contentContainer2{
                background-color: #c0b1cc;
                margin-top: 60px;
                margin-left: 14px;
                padding-left: 10px;
                padding-right: 30px;
                height: 1230px;
                margin-bottom: 20px;
                border-radius: 25px;
                box-shadow: 10px 12px #efe6fc;
        }
       

        .large-label {
            display: inline-block;
            font-size: 10px;
            font: bold 1rem sans-serif;
            margin-bottom: 0.5rem;
            padding-left:10px;
      }
            
        input[type=text] {
            width: 40%;
            padding: 8px 15px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 2px solid black;
            border-radius: 3px;
        }
        
        input[type=img] {
            width: 30%;
            padding: 8px 15px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 2px solid black;
            border-radius: 3px;
        }
        
        input[type=url] {
            width: 55%;
            padding: 8px 15px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 2px solid black;
            border-radius: 3px;
        }
        
        input[type=number] {
            width: 10%;
            padding: 5px 8px;
            margin: 6px 0;
            box-sizing: border-box;
            border: 2px solid black;
            border-radius: 3px;
        }
        
        input[type=date] {
            width: 30%;
            padding: 8px 15px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 2px solid black;
            border-radius: 3px;
        }
        
        input[type=checkbox], input[type=radio] {
            width: 5%;
            padding: 8px 5px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 2px solid black;
            border-radius: 3px;
        }
        
        textarea {
        width: 100%;
        height: 150px;
        padding-top: 3px;
        margin-left:10px;
        padding: 12px 20px;
        box-sizing: border-box;
        border: 2px solid #black;
        border-radius: 4px;
        background-color: #f8f8f8;
        font-size: 16px;
        resize: none;
      }
      
      fieldset {
        background-color: #eee1f7;
        margin-top: 17px;
        font-size: 10px;
        font: bold 1rem sans-serif;
        width: 430px;
        border: 1.5px solid black;
      }
      
      legend{
        background-color: #eee1f7;
        border-radius: 10px;
        color: black;
        padding: 5px 10px;
        margin-bottom: 10px;
      }
      
       input[type=submit], input[type=reset] {
        background: linear-gradient(to bottom, rgb(187, 166, 222), rgb(69, 28, 138));
        border: 1.5px solid #603f8f;
        border-radius: 5px;
        color: white;
        padding: 12px 28px;
        text-decoration: none;
        margin: 4px 10px;
        cursor: pointer;
      }
      
      input[type=submit]:hover, input[type=reset]:hover {
         opacity: 1.0;
         color:white;
         background: linear-gradient(to bottom, rgb(212, 158, 188), rgb(156, 122, 175));
        }

        </style>
    </head>
    
    <body>
                <div class="contentContainer1">
                <div class="row">
                 <div class="col1">
                    <a href="index.html"><img style="height: 80px; width: 80px; margin-top: 14px; margin-left: 20px;" src="logo.png" alt="CC Cinema Logo"></a>
                    <a href="index.html"><p><span style="margin-top: -43px; padding-bottom: 30px; margin-left: 20px;" class="title">CC CINEMA</span></a></p>
                    <h1  style="text-align: center; font-family: Georgia, 'Times New Roman', Times, serif; font-size: 25px; color:white; margin-top: -90px; margin-bottom: 30px; letter-spacing: 3px; font-size: 35px;"><u>ADD NEW MOVIE</u></h1>
                 </div>
                </div>
                    
                  <div class="contentContainer2">
                  <div class="col2" style="padding-top: 7px;">
                      <form action="GetNewMovieInfo" method="get">
                            <% Movie movie = new Movie(); %>
                            <p><label class="large-label">Movie ID:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                <input type="text" name="newMovieID" size="10" value="<%= movie.nextMovieID() %>" readonly /></p>
                            
                            <p><label class="large-label">Movie Name: </label>
                                <input type="text" name="newMovieName" size="12" required/></p>
                
                            <p><label class="large-label" for="url">Movie Trailer URL: </label>       
                                <input type="url" name="url" id="url" placeholder="https://youtube.com" size="40" /></p>
                            
                            <p><label class="large-label">Duration: </label>
                                <input type="number" name="hour" size="5" min="1" max="10" placeholder="1" /> hours  <input type="number" name="minutes" size="5" min="0" max="59" placeholder="00"/> minutes</p>
                                
                                <label class="large-label" for="dateAvailable">Available Date:</label>
                                <input type="date" id="dateAvailable" name="dateAvailable" min="2022-01-01"><br>
                            
                            <fieldset>
                                 <legend>Movie Poster</legend>
                            <p><label class="large-label" for="img">Choose File:</label>
                                <input type="file" id="img" name="posterImg" accept="image/*" required><br/>
                            
                                 <label class="large-label" for="url">URL: </label>       
                                <input type="url" name="posterImgURL" id="url"  size="50" placeholder="https://imagesUrlLink" required/></p>
                            </fieldset>
                                
                            <fieldset style="margin-left: 475px; margin-top: -165px; margin-bottom: 15px;">
                                <legend>Advertisement Poster</legend>
                            <p><label  class="large-label" for="img">Choose File:</label>
                                <input type="file" id="img" name="adsImg" accept="image/*" required><br/>

                                 <label class="large-label" for="url">URL: </label>       
                                <input type="url" name="adsImgURL" id="url"  size="50" placeholder="https://imagesUrlLink" required/></p>
                            </fieldset>
                      
                        <!--To load Movie Status option from database -->
                            <% MovieStatusDA movieStatusDA = new MovieStatusDA();
                                  ArrayList<MovieStatus> movieStatusList = new ArrayList<MovieStatus>();
                                  movieStatusList = movieStatusDA.getMovieStatusRecord(); %>
                            <p><label class="large-label">Movie Status: </label>
                                <% for(int a= 0; a<movieStatusList.size(); a++){ %>
                                <input type="radio" name="newMovieStatus" style="border: 2px solid black;" value="<%= movieStatusList.get(a).getMovieStatusID() %>"  required/><%= movieStatusList.get(a).getMovieStatusDesc() %>
                                <% } %>
                            
                            <!--To load Movie Restriction option from database -->
                            <% MovieRestrictionDA movieRestrictionDA = new MovieRestrictionDA();
                                  ArrayList<MovieRestriction> movieRestrictionList = new ArrayList<MovieRestriction>();
                                  movieRestrictionList = movieRestrictionDA.getMovieRestrictionRecord(); %>
                            <p><label class="large-label">Movie Restriction: </label>
                                <% for(int b= 0; b<movieRestrictionList.size(); b++){ %>
                                <input type="radio" name="newMovieRestriction"  style="border: 2px solid black;" value="<%= movieRestrictionList.get(b).getMovieRestrictID() %>" required/><%= movieRestrictionList.get(b).getRestrictionDesc() %>
                                 <% } %>
                                 
                            <!--To load Actor option from database -->
                           <% ActorDA actorDA = new ActorDA();
                                  ArrayList<Actor> actorList = new ArrayList<Actor>();
                                  actorList = actorDA.getActorRecord(); %>
                            <p><label class="large-label" style="padding: 8px 15px; margin: 8px 0;">Cast: </label>
                            <div style="margin-top: -60px; margin-left: 119px;">
                                <select name="newMovieActorList" style="width: 46%; height: 50%; padding: 8px 2px; margin: 8px 0; box-sizing: border-box; border: 2px solid black; border-radius: 3px;" multiple="multiple" required>
                                <% for(int k = 0; k< actorList.size(); k++){ %>
                                    <option style="padding: 8px 1px; margin-left: 9px;" value = "<%= actorList.get(k).getActorID() %>" ><%= actorList.get(k).getActorName() %></option>
                                <% } %>
                                </select></p>
                            </div>
                            
                            <!--To load MovieType option from database -->
                            <% MovieTypeDA movieTypeDA = new MovieTypeDA();
                                  ArrayList<MovieType> movieTypeList = new ArrayList<MovieType>();
                                  movieTypeList = movieTypeDA.getMovieTypeRecord(); %>
                            <p><label class="large-label">Movie Type: &nbsp;&nbsp;</label>
                                <select name="newMovieType" style="width: 40%; padding: 8px 15px; margin: 8px 0; box-sizing: border-box; border: 2px solid black; border-radius: 3px;" required>
                                    <% for(int j= 0; j< movieTypeList.size(); j++){ %>
                                    <option style="width: 40%; padding: 8px 15px; margin: 8px 0;" value = "<%= movieTypeList.get(j).getMovieTypeID() %>"><%= movieTypeList.get(j).getMovieTypeDesc() %></option>
                                     <% } %>
                                </select></p>
                                
                           <!--To load Language option from database -->
                           <% LanguageDA languageDA = new LanguageDA();
                                  ArrayList<Language> languageList = new ArrayList<Language>();
                                  languageList = languageDA.getLanguageRecord(); %>
                            <p><label class="large-label">Language: &nbsp;&nbsp;&nbsp;&nbsp;</label>
                                <select name="newMovielanguage" style="width: 40%; padding: 8px 15px; margin: 8px 0; box-sizing: border-box; border: 2px solid black; border-radius: 3px;" required>
                                <% for(int i= 0; i< languageList.size(); i++){ %>
                                    <option style="width: 40%; padding: 8px 15px; margin: 8px 0;" value = "<%= languageList.get(i).getLanguageID() %>"><%= languageList.get(i).getLanguageDesc() %></option>
                                <% } %>
                                </select></p>
                                
                             <p><label class="large-label">Synopsis: </label>
                            <textarea style="border: 2px solid black; border-radius: 3px;" id="synopsis" name="synopsis" rows="4" cols="50"></textarea></p>
                           
                            <p><input type="submit" value="Submit" />
                                <input type="reset" value="Reset" /></p>
                        </form>
                  </div>
                </div>
              </div>

                                
        </div>
 
    </body>
</html>
