<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchEmployee.aspx.cs" Inherits="SalesSystem.SearchEmployee" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Search</title>
    <script src="scripts/jquery.min.js" type="text/javascript"></script>
    <script src="scripts/chosen.jquery.js" type="text/javascript"></script>
    <link rel="stylesheet" href="Styles/style.css" />
    <link rel="stylesheet" href="Styles/prism.css" />
    <link rel="stylesheet" href="Styles/chosen.css" />
    <script src="ASPSnippets_Pager.min.js" type="text/javascript"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.7.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/jquery-ui.js"></script>
    <script type="text/javascript">

        //allowing age fields to numeric
        function ValidateAge(ageControl) {
            var age = ageControl.value;
            if (isNaN(age)) {
                alert('age should be a number.');
                ageControl.value = '';
            }
        }

        //searching employees
        function GetCustomers() {
            // debugger;
            var name = document.getElementById("txtName").value;
            var drpdesignation = document.getElementById("drpDesignation");
            var designation = drpdesignation.options[drpdesignation.selectedIndex].value;
            var ageField = document.getElementById("txtAge").value
            var contact = document.getElementById("txtContact").value;
            var passingData = {};
            passingData.name = name;
            passingData.designation = designation;
            passingData.age = Number(ageField);
            passingData.phone = contact;
            // so on...
            // }
            $.ajax({
                type: "POST",
                url: "SearchEmployee.aspx/GetCustomers",
                //data: '{pageIndex: ' + pageIndex + '}',
                data: JSON.stringify(passingData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }

        //binding grid on successfull response.
        function OnSuccess(response) {
            // debugger;
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Table");
            var row = $("[id*=gvCustomers] tr:last-child").clone(true);
            $("[id*=gvCustomers] tr").not($("[id*=gvCustomers] tr:first-child")).remove();
            $.each(customers, function () {
                var customer = $(this);
                var count = 1;
                $("td", row).eq(1).html(count);
                count += 1;
                $("td", row).eq(1).html($(this).find("employeeID").text());
                $("td", row).eq(2).html($(this).find("name").text());
                $("td", row).eq(3).html($(this).find("age").text());
                $("td", row).eq(4).html($(this).find("phone").text());
                $("td", row).eq(5).html($(this).find("designation").text());
                //$("td", row).eq(5).html($(this).find("age").text());
                $("[id*=gvCustomers]").append(row);
                row = $("[id*=gvCustomers] tr:last-child").clone(true);
            });
            document.getElementById('searchResults').style.display = 'block';
        }

        //loading Edit screen.
        function OnSuccessEmpoyeeData(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Customers");
            $.each(customers, function () {
                var customer = $(this);
                $('#txtEmpId_edit').text($(this).find("employeeID").text());
                $('#txtName_edit').text($(this).find("name").text());
                $('#drpDesignation_edit').val($(this).find("designation").text());
                $('#txtAge_edit').text($(this).find("age").text());
                $('#txtContact_edit').text($(this).find("phone").text());
                if ($(this).find("canAddClient").text() == 1)
                    $("#chkAddClient").prop("checked", true);
                else
                    $("#chkAddClient").prop("checked", false);

                if ($(this).find("canModifyClient").text() == 1)
                    $("#chkModifyClient").prop("checked", true);
                else
                    $("#chkModifyClient").prop("checked", false);
                if ($(this).find("canDeleteClient").text() == 1)
                    $("#chkDeleteClient").prop("checked", true);
                else
                    $("#chkDeleteClient").prop("checked", false);
                if ($(this).find("canCreateQuotation").text() == 1)
                    $("#chkCreateQuotation").prop("checked", true);
                else
                    $("#chkCreateQuotation").prop("checked", false);
                if ($(this).find("canViewQuotation").text() == 1)
                    $("#chkViewQuotation").prop("checked", true);
                else
                    $("#chkViewQuotation").prop("checked", false);
                if ($(this).find("canReviewQuotation").text() == 1)
                    $("#chkReviewQuotation").prop("checked", true);
                else
                    $("#chkReviewQuotation").prop("checked", false);
                if ($(this).find("canGeneratePerformaInvoice").text() == 1)
                    $("#chkGeneratePerformaInvoice").prop("checked", true);
                else
                    $("#chkGeneratePerformaInvoice").prop("checked", false);
                if ($(this).find("canGenerateInvoice").text() == 1)
                    $("#chkGenerateInvoice").prop("checked", true);
                else
                    $("#chkGenerateInvoice").prop("checked", false);
                if ($(this).find("canGenerateGRV").text() == 1)
                    $("#chkGenerateGRV").prop("checked", true);
                else
                    $("#chkGenerateGRV").prop("checked", false);
                if ($(this).find("canViewSalesReport").text() == 1)
                    $("#chkViewSalesReport").prop("checked", true);
                else
                    $("#chkViewSalesReport").prop("checked", false);
                if ($(this).find("canViewClientsReport").text() == 1)
                    $("#chkViewClientsReport").prop("checked", true);
                else
                    $("#chkViewClientsReport").prop("checked", false);
                if ($(this).find("canViewTurnoverReport").text() == 1)
                    $("#chkViewTurnoverReport").prop("checked", true);
                else
                    $("#chkViewTurnoverReport").prop("checked", false);
                if ($(this).find("canViewQuotationReport").text() == 1)
                    $("#chkViewQuotationReport").prop("checked", true);
                else
                    $("#chkViewQuotationReport").prop("checked", false);
                if ($(this).find("canAuditQuotationReport").text() == 1)
                    $("#chkAuditQuotationReport").prop("checked", true);
                else
                    $("#chkAuditQuotationReport").prop("checked", false);
            });

            document.getElementById('divEdit').style.display = 'block';
        }

        //clicked on modify for a employee
        function MoveToEdit(row) {
            debugger;
            var rowData = row.parentNode.parentNode;
            var EmployeeID = rowData.EmployeeID;//.rowIndex;
            $.ajax({
                type: "POST",
                url: "SearchEmployee.aspx/GetCustomerDetails",
                data: '{employeeID: ' + EmployeeID + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccessEmpoyeeData,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });


            // popup = window.open("/Machinery/lookup/machine_lookup.aspx", "Popup", "width=800");
            //popup.focus();
        }

        //validating Controls. on update
        function validateEdit() {
            var errorCount = 0;
            if ($('#txtName_edit').text() == '')
                errorCount = errorCount + 1;
            if ($('#drpDesignation_edit').val() == '')
                errorCount = errorCount + 1;
            if ($('#txtAge_edit').text() == '')
                errorCount = errorCount + 1;
            if ($('#txtContact_edit').text() == '')
                errorCount = errorCount + 1;
            
            if (errorCount > 0)
            {
                alert('please fill the mandatory fields: Name, Designation, Age and Contact.');
                return false;
            }
            return true;

        }

        //save data to DB once click on Save
        function SaveData() {
            var valid = validateEdit();//validating the fields.
            if (valid) {
                var id = $('#txtEmpId_edit').text();
                var name = $('#txtName_edit').text();
                var designation = $('#drpDesignation_edit').val();
                var age = $('#txtAge_edit').text();
                var contact = $('#txtContact_edit').text();

                var canAddClient = 0;
                if (document.getElementById('chkAddClient').checked) {
                    canAddClient = 1;
                }
                var canModifyClient = 0;
                if (document.getElementById('chkModifyClient').checked) {
                    canModifyClient = 1;
                }
                var canDeleteClient = 0;
                if (document.getElementById('chkDeleteClient').checked) {
                    canDeleteClient = 1;
                }
                var canCreateQuotation = 0;
                if (document.getElementById('chkCreateQuotation').checked) {
                    canCreateQuotation = 1;
                }
                var canViewQuotation = 0;
                if (document.getElementById('chkViewQuotation').checked) {
                    canViewQuotation = 1;
                }
                var canReviewQuotation = 0;
                if (document.getElementById('chkReviewQuotation').checked) {
                    canReviewQuotation = 1;
                }
                var canGeneratePerformaInvoice = 0;
                if (document.getElementById('chkGeneratePerformaInvoice').checked) {
                    canGeneratePerformaInvoice = 1;
                }
                var canGenerateInvoice = 0;
                if (document.getElementById('chkGenerateInvoice').checked) {
                    canGenerateInvoice = 1;
                }
                var canGenerateGRV = 0;
                if (document.getElementById('chkGenerateGRV').checked) {
                    canGenerateGRV = 1;
                }
                var canViewSalesReport = 0;
                if (document.getElementById('chkViewSalesReport').checked) {
                    canViewSalesReport = 1;
                }
                var canViewClientsReport = 0;
                if (document.getElementById('chkViewClientsReport').checked) {
                    canViewClientsReport = 1;
                }
                var canViewTurnoverReport = 0;
                if (document.getElementById('chkViewTurnoverReport').checked) {
                    canViewTurnoverReport = 1;
                }
                var canViewQuotationReport = 0;
                if (document.getElementById('chkViewQuotationReport').checked) {
                    canViewQuotationReport = 1;
                }
                var canAuditQuotationReport = 0;
                if (document.getElementById('chkAuditQuotationReport').checked) {
                    canAuditQuotationReport = 1;
                }
                var passingData = {};
                passingData.employeeID = id;
                passingData.name = name;
                passingData.designation = designation;
                passingData.age = Number(ageField);
                passingData.phone = contact;
                passingData.canAddClient = canAddClient;
                passingData.canModifyClient = canModifyClient;
                passingData.canDeleteClient = canDeleteClient;
                passingData.canCreateQuotation = canCreateQuotation;
                passingData.canViewQuotation = canViewQuotation;
                passingData.canReviewQuotation = canReviewQuotation;
                passingData.canGeneratePerformaInvoice = canGeneratePerformaInvoice;
                passingData.canGenerateInvoice = canGenerateInvoice;
                passingData.canGenerateGRV = canGenerateGRV;
                passingData.canViewSalesReport = canViewSalesReport;
                passingData.canViewClientsReport = canViewClientsReport;
                passingData.canViewTurnoverReport = canViewTurnoverReport;
                passingData.canViewQuotationReport = canViewQuotationReport;
                passingData.canAuditQuotationReport = canAuditQuotationReport;
                $.ajax({
                    type: "POST",
                    url: "SearchEmployee.aspx/UpdateCustomer",
                    data: JSON.stringify(passingData),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccessUpdate,
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });
            }
            else {
                return false;
            }
        }

        //checked select all option then make all check boxes checked.
        function SelectAll() {
            if (document.getElementById('chkSelectAll').checked) {
                $("#chkAddClient").prop("checked", true);
                $("#chkModifyClient").prop("checked", true);
                $("#chkDeleteClient").prop("checked", true);
                $("#chkCreateQuotation").prop("checked", true);
                $("#chkViewQuotation").prop("checked", true);
                $("#chkReviewQuotation").prop("checked", true);
                $("#chkGeneratePerformaInvoice").prop("checked", true);
                $("#chkGenerateInvoice").prop("checked", true);
                $("#chkGenerateGRV").prop("checked", true);
                $("#chkViewSalesReport").prop("checked", true);
                $("#chkViewClientsReport").prop("checked", true);
                $("#chkViewTurnoverReport").prop("checked", true);
                $("#chkViewQuotationReport").prop("checked", true);
                $("#chkAuditQuotationReport").prop("checked", true);
            }
            else {
                $("#chkAddClient").prop("checked", false);
                $("#chkModifyClient").prop("checked", false);
                $("#chkDeleteClient").prop("checked", false);
                $("#chkCreateQuotation").prop("checked", false);
                $("#chkViewQuotation").prop("checked", false);
                $("#chkReviewQuotation").prop("checked", false);
                $("#chkGeneratePerformaInvoice").prop("checked", false);
                $("#chkGenerateInvoice").prop("checked", false);
                $("#chkGenerateGRV").prop("checked", false);
                $("#chkViewSalesReport").prop("checked", false);
                $("#chkViewClientsReport").prop("checked", false);
                $("#chkViewTurnoverReport").prop("checked", false);
                $("#chkViewQuotationReport").prop("checked", false);
                $("#chkAuditQuotationReport").prop("checked", false);
            }
        }

        // if Updated Successfully redirect to Search Page.
        function OnSuccessUpdate(response) {
            var returncode = response.d;

            if (returncode) {
                alert('Updated Successfully');
                document.getElementById('divEdit').style.display = 'none';
                document.getElementById('divSearchCriteria').style.display = 'block';
            }
            else {
                alert("technical difficulties.");
            }
        }
    </script>

    <style type="text/css">
        body {
            font-family: Arial;
            font-size: 10pt;
        }

        .Pager span {
            text-align: center;
            color: #999;
            display: inline-block;
            width: 20px;
            background-color: #A1DCF2;
            margin-right: 3px;
            line-height: 150%;
            border: 1px solid #3AC0F2;
        }

        .Pager a {
            text-align: center;
            display: inline-block;
            width: 20px;
            background-color: #3AC0F2;
            color: #fff;
            border: 1px solid #3AC0F2;
            margin-right: 3px;
            line-height: 150%;
            text-decoration: none;
        }

        a img {
            border: none;
        }

        ol li {
            list-style: decimal outside;
        }

        div#container {
            width: 780px;
            margin: 0 auto;
            padding: 1em 0;
        }

        div.side-by-side {
            width: 100%;
            margin-bottom: 1em;
        }

            div.side-by-side > div {
                float: left;
                width: 50%;
            }

                div.side-by-side > div > em {
                    margin-bottom: 10px;
                    display: block;
                }

        .clearfix:after {
            content: "\0020";
            display: block;
            height: 0;
            clear: both;
            overflow: hidden;
            visibility: hidden;
        }

        .width {
            width: 300px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="divSearchCriteria">
            <table>
                <tr>
                    <td>
                        <label>Name : </label>
                    </td>
                    <td>
                        <input id="txtName" runat="server" type="text" class="width" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Designation : </label>
                    </td>
                    <td>
                        <asp:DropDownList ID="drpDesignation" class="chzn-select width" runat="server" data-placeholder="Choose a Country...">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="Software Engineer" Value="SE"></asp:ListItem>
                            <asp:ListItem Text=" Senior Software Engineer" Value="SSE"></asp:ListItem>
                            <asp:ListItem Text="Sales Officer" Value="SO"></asp:ListItem>
                            <asp:ListItem Text="Senior Sales Officer" Value="SE"></asp:ListItem>
                        </asp:DropDownList>
                        <script src="Scripts/jquery.min.js" type="text/javascript"></script>
                        <script src="Scripts/chosen.jquery.js" type="text/javascript"></script>
                        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Age range : </label>
                    </td>
                    <td>
                        <input id="txtAge" runat="server" type="text" onkeydown="ValidateAge(this);" onkeyup="ValidateAge(this);" class="width" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Contact  Number: </label>
                    </td>
                    <td>
                        <input id="txtContact" runat="server" type="text" class="width" />
                    </td>
                </tr>
                <tr>
                    <td style="align-items: center">
                        <input id="Text3" runat="server" type="button" onclick="GetCustomers(); return false;" name="Search" value="Search" />
                    </td>
                </tr>
            </table>
        </div>

        <div id="searchResults" style="display: none">
            <asp:GridView runat="server" ID="gvCustomers" AutoGenerateColumns="false" RowStyle-BackColor="#A1DCF2"
                HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White">
                <Columns>
                    <asp:BoundField ItemStyle-Width="150px" DataField="SRNumber" HeaderText="SR No" />
                    <asp:BoundField ItemStyle-Width="150px" DataField="employeeID" HeaderText="Employee ID" />
                    <asp:BoundField ItemStyle-Width="150px" DataField="name" HeaderText="NAME" />
                    <asp:BoundField ItemStyle-Width="150px" DataField="age" HeaderText="Age" />
                    <asp:BoundField ItemStyle-Width="150px" DataField="phone" HeaderText="phone" />
                    <asp:BoundField ItemStyle-Width="150px" DataField="designation" HeaderText="Designation" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button OnClientClick="MoveToEdit(this);" Text="Modify" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>

        </div>
        <div id="divEdit" style="display:none">
            <table>
                <tr>
                    <td>
                        <label>Employee Id : </label>
                    </td>
                    <td>
                        <input id="txtEmpId_edit" runat="server" type="text" class="width" disabled ="disabled" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Name : </label>
                    </td>
                    <td>
                        <input id="txtName_edit" runat="server" type="text" class="width" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Designation : </label>
                    </td>
                    <td>
                        <asp:DropDownList ID="drpDesignation_edit" class="chzn-select width" runat="server" data-placeholder="Choose a Country...">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="Software Engineer" Value="SE"></asp:ListItem>
                            <asp:ListItem Text=" Senior Software Engineer" Value="SSE"></asp:ListItem>
                            <asp:ListItem Text="Sales Officer" Value="SO"></asp:ListItem>
                            <asp:ListItem Text="Senior Sales Officer" Value="SE"></asp:ListItem>
                        </asp:DropDownList>
                        <script src="Scripts/jquery.min.js" type="text/javascript"></script>
                        <script src="Scripts/chosen.jquery.js" type="text/javascript"></script>
                        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Age range : </label>
                    </td>
                    <td>
                        <input id="txtAge_edit" runat="server" type="text" onkeydown="ValidateAge(this);" onkeyup="ValidateAge(this);" class="width" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>Contact  Number: </label>
                    </td>
                    <td>
                        <input id="txtContact_edit" runat="server" type="text" class="width" />
                    </td>
                </tr>

            </table>
            <table>
                <tr>
                    <td>
                        <asp:CheckBox ID="chkAddClient" runat="server" Text="Add Client" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkModifyClient" runat="server" Text="Modify Client" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkDeleteClient" runat="server" Text="Delete Client" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBox ID="chkCreateQuotation" runat="server" Text="create quotation" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkViewQuotation" runat="server" Text="View quotation" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkReviewQuotation" runat="server" Text="Review quotation" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBox ID="chkGeneratePerformaInvoice" runat="server" Text="Generate Performa invoice" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkGenerateInvoice" runat="server" Text="Generate Invoice" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkGenerateGRV" runat="server" Text="Generate GRV" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBox ID="chkViewSalesReport" runat="server" Text="view sales reports" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkViewClientsReport" runat="server" Text="view clients report" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkViewTurnoverReport" runat="server" Text="view turnover report" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBox ID="chkViewQuotationReport" runat="server" Text="view quotation report" />
                    </td>
                    <td>
                        <asp:CheckBox ID="chkAuditQuotationReport" runat="server" Text="audit quotation change" />
                    </td>
                    <td></td>
                </tr>
                 <tr>
                    <td>
                        <asp:CheckBox ID="chkSelectAll" runat="server" Text="Select All" OnCheckedChanged="JavaScript:SelectAll()" />
                    </td>
                    
                </tr>
                <tr>
                    <td style="align-items: center">
                        <input id="Button1" runat="server" type="button" name="Save" value="Save" onclick="SaveData(); return false;" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
