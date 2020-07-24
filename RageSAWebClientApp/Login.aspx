<%@ Page Title="Login" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.vb" Inherits="RageSAWebClientApp.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <script type="text/javascript">
            $(document).ready(function () {
                $("#btnLogin").click(function () {
                    var urlParams = new URLSearchParams(window.location.search);
                    var entered_username = $("#txtUsername").val();
                    var entered_password = $("#txtPassword").val();
                    
                    if (entered_password && entered_password.length > 0 && entered_username && entered_username.length > 0) {

                        if (urlParams.get('branch')) {
                            branch_code = urlParams.getAll('branch');
                            var data = '<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetUsersTesting xmlns=\"http://tempuri.org/\"><Password>hajJwy2*uqyn1</Password><BranchCode>' + urlParams.getAll('branch')[0] + '</BranchCode></GetUsersTesting></soap:Body></soap:Envelope>';

                            $.ajax({
                                url: "http://myrage.co.za/testing/testing.asmx",
                                method: "POST",
                                headers: {
                                    "Content-Type": "text/xml; charset=utf-8"
                                },
                                data: data,
                                success: function (xml) { 
                                    
                                    var doc = $(xml.documentElement);
                                    
                                    doc.find("UserPermissions").each(function (index, el) {
                                        let user_name = $(el).find('user_name').first().text();
                                        let user_password = $(el).find('user_password').first().text();
                                        if (user_name === entered_username && user_password === entered_password) {
                                            alert("User has successfully logged in");
                                            window.location.href = "Stockcodes.aspx?isloggedin=true";
                                            
                                        }
                                        else {
                                            
                                            var message = "Invalid username & password combination for selected branch: " + urlParams.getAll('branch')[0];
                                            alert(message);
                                        }
                                      

                                    });
                                    //only goes here if they are no login credentials for the branch available
                                    alert("Cannot login on this branch. Try another branch or contact the Rage customer service team");

                                },
                                error: function (err) {
                                    alert("unknown error");
                                }
                            });

                        }

                        else {
                            alert("No value was found for the banch. Please seect a branch from the home page");
                        }
                        
                    }

                    else {
                        alert("Please enter a username and password to proceed");
                    }
                   
                });

            });
       </script>
        <div class="container" style="margin-top: 50px">
            <div style="border: 1px solid black;border-radius:5px; padding: 3%;" id="loginDiv">
                <h1>Login Page</h1><br />
                <div class="form-group">
                   <label for="txtUsername">Username</label>
                   <input type="text" class="form-control" id="txtUsername" />
                </div> 
                 <div class="form-group">
                   <label for="txtPassword">Password</label>
                   <input type="password" class="form-control" id="txtPassword" />
                </div>
                
                <input class="btn btn-primary" type="button" id="btnLogin" value="Button" />
            </div>  
            
        </div>
</asp:Content>
