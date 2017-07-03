using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SalesSystem.DAL;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
namespace SalesSystem.BAL
{
    public class EmployeeBAL
    {
        
        public static DataSet GetData(SqlCommand cmd)
        {

            return EmployeeDAL.GetData(cmd);
        }

        public static int Save(SqlCommand cmd)
        {
            return EmployeeDAL.Save(cmd);
        }
        public static DataSet GetUserDetails(SqlCommand cmd)
        {
            return EmployeeDAL.GetUserDetails(cmd);
        }

    }
}