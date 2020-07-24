<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="RageSAWebClientApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function Login(branch_code) {
            window.location.href = "Login.aspx?branch=" + branch_code;
        }

        $(document).ready(function () {
            var data = '<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n  <soap:Body>\n    <GetBranches xmlns=\"http://tempuri.org/\">\n<Password>' + 'hajJwy2*uqyn1' + '</Password>\n</GetBranches>\n  </soap:Body>\n</soap:Envelope>';
                $.ajax({
                    url: "http://myrage.co.za/testing/testing.asmx",
                    method: "POST",
                    headers: {
                        "Content-Type": "text/xml; charset=utf-8"
                    },
                    data: data,
                    success: function (xml) {
                        var doc = $(xml.documentElement);
                        doc.find("Branch").each(function (index, el) {
                            let branch_type = $(el).find('branch_code').first().text();
                            let branch_name = $(el).find('branch_name').first().text();
                            let title = branch_name + " - " + branch_type;
                            let a1 = $(el).find('address_line_1').first().text();
                            let a2 = $(el).find('address_line_2').first().text();
                            let a3 =$(el).find('address_line_4').first().text();
                            let a4 =$(el).find('address_line_3').first().text();
                            let a5 =$(el).find('address_line_5').first().text();


                            let address = "";
                            if (a1 != "") {
                                address = address + a1;
                            }
                            if (a2 != "") {
                                address = address + "," + a2;
                            }
                            if (a3 != "") {
                                address = address + "," + a3;
                            }
                            if (a4 != "") {
                                address = address + "," + a4;
                            }
                            if (a5 != "") {
                                address = address + "," + a5;
                            }

                         
                            let telephone = $(el).find('telephone_number').first().text();
                            let row = "<div class='col-md-4'style='padding: 2%; text-align: center; height: 250px'> <div style='border: 3px solid red; border-radius: 5px'> <h5 style='margin-bottom: 2%;font-weight: bold'>" + title
                                + "</h5><div style='margin-bottom: 2%'> " + address + "</div>"
                                + "<div style = 'margin-bottom: 2%'>" + telephone + "</div>"
                                + "<div><br><button type='button' onclick='Login(\"" + branch_type + "\")' class='btn btn-secondary btn-lg btn-block'>View Stock Codes</button></div> ";
                            $("#branchlist").append(row);

                            $("#load_gif").css("display", "none");
                        });
                    },
                    error: function (err) {
                        $("#load_gif").css("display", "none");
                        alert("Unknown Error. Please contact the Administrator");
                    }
                }); 
            
   
        });

    </script>

    <div class="container">
        <h1>Branch Listing</h1>
        <div id="branchlist"></div>
        <div id="load_gif">
            <img src="Content/Images/ajax-loader.gif" />
        </div>
        
    </div>


</asp:Content>
