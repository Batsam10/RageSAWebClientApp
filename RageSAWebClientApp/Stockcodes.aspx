<%@ Page Title="Stockcodes" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true"  CodeBehind="Stockcodes.aspx.vb" Inherits="RageSAWebClientApp.Stockcodes" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {

            var urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('isloggedin') && urlParams.getAll('isloggedin')[0] == "true") {

                var settings = {
                    "url": "http://myrage.co.za/testing/testing.asmx",
                    "method": "POST",
                    "timeout": 0,
                    "headers": {
                        "Content-Type": "text/xml"
                    },
                    "data": "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\r\n  <soap:Body>\r\n    <GetSomeStockcodesTesting xmlns=\"http://tempuri.org/\" />\r\n  </soap:Body>\r\n</soap:Envelope>",
                };

                $.ajax(settings).done(function (xml) {
                    $("#stockDiv").css("visibility", "visible");
                    var doc = $(xml.documentElement);
                    doc.find("Stockcodes").each(function (index, el) {
                        let generated_code = $(el).find('generated_code').first().text();
                        let sku_number = $(el).find('sku_number').first().text();
                        let is_service_item = $(el).find('is_service_item').first().text();
                        let description = $(el).find('description').first().text();
                        let item_size = $(el).find('item_size').first().text();
                        let category_1 = $(el).find('category_1').first().text();
                        let category_2 = $(el).find('category_2').first().text();
                        let category_3 = $(el).find('category_3').first().text();
                        let row = "<tr><td>" + generated_code
                            + "</td><td>" + sku_number
                            + "</td><td>" + is_service_item
                            + "</td><td>" + description
                            + "</td><td>" + item_size
                            + "</td><td>" + category_1
                            + "</td><td>" + category_2
                            + "</td><td>" + category_3
                            + "</td></tr>";
                        $("#tbody").append(row);
                    });
                    $("#load_gif").css("display", "none");
                });

            }
            else {
                $("#load_gif").css("display", "none");
                alert("Please login to proceed");
            }
        });
    </script>
         <div id="load_gif">
            <img src="Content/Images/ajax-loader.gif" />
        </div>
   <div id="stockDiv" style="visibility:hidden">
      <h1>Stock Codes</h1>
   
   <table class="table table-striped">
    <thead>
    <tr>
      <th scope="col">generated_code</th>
      <th scope="col">sku_number</th>
      <th scope="col">is_service_item</th>
      <th scope="col">description</th>
      <th scope="col">item_size</th>
      <th scope="col">category_1</th> 
      <th scope="col">category_2</th>
      <th scope="col">category_3</th>
    </tr>
    </thead>
    <tbody id="tbody"></tbody>
   </table>
  </div>
</asp:Content>

