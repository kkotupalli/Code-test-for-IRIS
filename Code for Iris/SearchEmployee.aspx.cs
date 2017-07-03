using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;
using SalesSystem.BAL;

namespace SalesSystem
{

    public partial class SearchEmployee : System.Web.UI.Page
    {

        //private static int PageSize = 10;
        protected void Page_Load(object sender, EventArgs e)
        {

            //load designations here, if from DB.

            if (!IsPostBack)
            {
                this.BindDummyRow();
            }
        }
        private void BindDummyRow()
        {
            DataTable dummy = new DataTable();
            dummy.Columns.Add("SRNumber");
            dummy.Columns.Add("employeeID");
            dummy.Columns.Add("name");
            dummy.Columns.Add("age");
            dummy.Columns.Add("designation");
            dummy.Columns.Add("phone");
            dummy.Rows.Add();
            gvCustomers.DataSource = dummy;
            gvCustomers.DataBind();
        }
        [WebMethod]
        public static string GetCustomers(string name, string designation, int age, string phone)
        {
            string query = "[getEmployeeDetails]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@employeename", name);
            cmd.Parameters.AddWithValue("@designation", designation);
            cmd.Parameters.AddWithValue("@age", age);
            cmd.Parameters.AddWithValue("@contact", phone);

            return EmployeeBAL.GetData(cmd).GetXml();
        }

        [WebMethod]
        public static string GetCustomerDetails(int employeeID)
        {
            string query = "[GetCustomerDetails]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
            return EmployeeBAL.GetUserDetails(cmd).GetXml();
        }

       

        [WebMethod]
        public static int UpdateCustomer(string employeeID, string name, string designation, int age, string phone, bool canAddClient,
            bool canModifyClient, bool canDeleteClient, bool canCreateQuotation, bool canViewQuotation, bool canReviewQuotation,
            bool canGeneratePerformaInvoice, bool canGenerateInvoice, bool canGenerateGRV, bool canViewSalesReport, bool canViewClientsReport,
            bool canViewTurnoverReport, bool canViewQuotationReport, bool canAuditQuotationReport)
        {
            string query = "[UpdateUserData]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@designation", designation);
            cmd.Parameters.AddWithValue("@age", age);
            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@canAddClient", canAddClient);
            cmd.Parameters.AddWithValue("@canModifyClient", canModifyClient);
            cmd.Parameters.AddWithValue("@canDeleteClient", canDeleteClient);
            cmd.Parameters.AddWithValue("@canCreateQuotation", canCreateQuotation);
            cmd.Parameters.AddWithValue("@canViewQuotation", canViewQuotation);
            cmd.Parameters.AddWithValue("@canReviewQuotation", canReviewQuotation);
            cmd.Parameters.AddWithValue("@canGeneratePerformaInvoice", canGeneratePerformaInvoice);
            cmd.Parameters.AddWithValue("@canGenerateInvoice", canGenerateInvoice);
            cmd.Parameters.AddWithValue("@canGenerateGRV", canGenerateGRV);
            cmd.Parameters.AddWithValue("@canViewSalesReport", canViewSalesReport);
            cmd.Parameters.AddWithValue("@canViewClientsReport", canViewClientsReport);
            cmd.Parameters.AddWithValue("@canViewTurnoverReport", canViewTurnoverReport);
            cmd.Parameters.AddWithValue("@canViewQuotationReport", canViewQuotationReport);
            cmd.Parameters.AddWithValue("@canAuditQuotationReport", canAuditQuotationReport);
           
            return EmployeeBAL.Save(cmd);

        }

        

    }


}