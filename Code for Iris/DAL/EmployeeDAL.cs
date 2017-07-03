using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;

namespace SalesSystem.DAL
{
    public class EmployeeDAL
    {
        public static DataSet GetData(SqlCommand cmd)
        {
            string strConnString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        sda.Fill(ds);

                        return ds;
                    }
                }
            }
        }
        public static int Save(SqlCommand cmd)
        {
            string strConnString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    SqlParameter returnParameter = cmd.Parameters.Add("RetVal", SqlDbType.Int);
                    returnParameter.Direction = ParameterDirection.ReturnValue;
                    cmd.ExecuteNonQuery();

                    int id = (int)returnParameter.Value;
                    return id;
                }
            }
        }
        public static DataSet GetUserDetails(SqlCommand cmd)
        {
            string strConnString = ConfigurationManager.ConnectionStrings["conString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        sda.Fill(ds);

                        return ds;
                    }
                }
            }
        }
    }
}