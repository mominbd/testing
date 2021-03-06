﻿using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Data.Odbc;
using System.Collections.ObjectModel;

/// <summary>
/// Summary description for Domain
/// </summary>
public class Domain
{
    string connectionString;
	public Domain()
	{
        connectionString = System.Web.Configuration.WebConfigurationManager.AppSettings["ConnectionString"].ToString();
	}

    #region Public Properties

    public int DomainOID
    { get; set; }
    
    public string DomainName
    { get; set; }

    public DateTime  CreatedDate
    { get; set; }

    public int  CreatedBy
    { get; set; }

    public DateTime  LastModifiedDate
    { get; set; }

    public int  LastModifiedBy
    { get; set; }
       

    #endregion

    public int GetDomainOIDByDomainName(string Name)
    {
        //Collection<Student> studentList = new Collection<Student>();
        Student student = null;
        int DomainOID;
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {

                command.Connection = connection;
                command.CommandText = "{CALL DomainOID_ByDomainName(?)}";
                command.CommandType = CommandType.StoredProcedure;

                //Set Parameter Value
                command.Parameters.AddWithValue("@Name", Name);
                //Open connection
                connection.Open();
                //Read using reader
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    //Question q = new Question();
                    dataReader.Read();
                    //while (dataReader.Read())
                    {
                        //student = new Student();
                        DomainOID = Convert.ToInt32(dataReader["DomainOID"]);
                        // studentList.Add(student);

                    }
                }

            }
        }
        return DomainOID;
    }

    public Collection <Domain> GetAllDomain()
    {
        Collection<Domain> DomainList = new Collection<Domain>();
       
        Domain domain = null;
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {

                command.Connection = connection;
                command.CommandText = "{CALL Domain_GetAll}";
                command.CommandType = CommandType.StoredProcedure;

                //Set Parameter Value
                //command.Parameters.AddWithValue("@Name", Name);
                //Open connection
                connection.Open();
                //Read using reader
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    //Question q = new Question();
                    while (dataReader.Read())
                     {
                        domain = new Domain();
                        //student = new Student();
                        //DomainOID = Convert.ToInt32(dataReader["DomainOID"]);
                        domain.DomainName = Convert.ToString(dataReader["DomainName"]);
                        DomainList.Add(domain);

                    }
                }

            }
        }
        return DomainList;
    }
   

    //public Collection<Interventions> GetAllIntervention(string numberOfRows, string pageIndex, string sortColumnName, string sortOrderBy, out int totalRecords, int UserOID)
    //{
    //    //Interventions u = null;
    //    Collection<Interventions> invList = new Collection<Interventions>();
    //    using (OdbcConnection connection = new OdbcConnection(connectionString))
    //    {
    //        using (OdbcCommand command = new OdbcCommand())
    //        {

    //            command.Connection = connection;
    //            command.CommandText = "{CALL SelectjqGrid_Prescription(?,?,?,?,?,?)}";
    //            command.CommandType = CommandType.StoredProcedure;

    //            OdbcParameter paramPageIndex = new OdbcParameter("@PageIndex", OdbcType.Int);
    //            paramPageIndex.Value = Convert.ToInt32(pageIndex);
    //            command.Parameters.Add(paramPageIndex);

    //            OdbcParameter paramColumnName = new OdbcParameter("@SortColumnName", OdbcType.VarChar, 50);
    //            paramColumnName.Value = sortColumnName;
    //            command.Parameters.Add(paramColumnName);

    //            OdbcParameter paramSortorderBy = new OdbcParameter("@SortOrderBy", OdbcType.VarChar, 4);
    //            paramSortorderBy.Value = sortOrderBy;
    //            command.Parameters.Add(paramSortorderBy);

    //            OdbcParameter paramNumberOfRows = new OdbcParameter("@NumberOfRows", OdbcType.Int);
    //            paramNumberOfRows.Value = Convert.ToInt32(numberOfRows);
    //            command.Parameters.Add(paramNumberOfRows);

    //            OdbcParameter paramUserOID = new OdbcParameter("@UserOID", OdbcType.Int);
    //            paramUserOID.Value = Convert.ToInt32(UserOID);
    //            command.Parameters.Add(paramUserOID);

    //            OdbcParameter paramTotalRecords = new OdbcParameter("@TotalRecords", OdbcType.Int);
    //            totalRecords = 0;
    //            paramTotalRecords.Value = totalRecords;
    //            paramTotalRecords.Direction = ParameterDirection.Output;
    //            command.Parameters.Add(paramTotalRecords);

    //            connection.Open();
    //            using (OdbcDataReader dataReader = command.ExecuteReader())
    //            {
    //                Interventions u;
    //                while (dataReader.Read())
    //                {
    //                    u = new Interventions();
    //                    u.PrescriptionOID = (int)dataReader["PrescriptionOID"];
    //                    u.StudentOID = (int)dataReader["StudentOID"];
    //                    u.UserOID = (int)dataReader["UserOID"];
    //                    //u.UserName = (string)dataReader["UserName"];
    //                    u.DomainOID = (int)dataReader["DomainOID"];
    //                    //u.DomainName = (string)dataReader["DomainName"];
    //                    u.InterventionOID = (int)dataReader["InterventionOID"];
    //                    //u.InterventionName = (string)dataReader["InterventionName"];
    //                    if (dataReader["LatestActionDate"] != null)
    //                    {
    //                        u.LatestActionDate = Convert.ToDateTime(dataReader["LatestActionDate"]).ToShortDateString();
    //                    }
    //                    if (dataReader["LatestContact"] != null)
    //                    {
    //                        u.LatestContact = Convert.ToDateTime(dataReader["LatestContact"]).ToShortDateString();
    //                    }
    //                    u.Internal = (int)dataReader["Internal"];
    //                    u.Prescribed = (int)dataReader["Prescribed"];
    //                    u.Completed = (int)dataReader["Completed"];
    //                    u.Email = (int)dataReader["Email"];
    //                    u.Telephone = (int)dataReader["Telephone"];
    //                    u.InPerson = (int)dataReader["InPerson"];
    //                    u.HandOff = (int)dataReader["HandOff"];
    //                    if (dataReader["CreatedDate"] != null)
    //                    {
    //                        u.CreatedDate = Convert.ToDateTime(dataReader["CreatedDate"]).ToShortDateString();
    //                    }
    //                    u.CreatedBy = (int)dataReader["CreatedBy"];
    //                    if (dataReader["LastModifiedDate"] != null)
    //                    {
    //                        u.LastModifiedDate = Convert.ToDateTime(dataReader["LastModifiedDate"]).ToShortDateString();
    //                    }
    //                    u.LastModifiedBy = (int)dataReader["LastModifiedBy"];
    //                    u.Comment = (string)dataReader["Comment"];
    //                    u.DomainName = (string)dataReader["BannerStudentName"];

    //                    invList.Add(u);

    //                }
    //            }

    //            totalRecords = (int)paramTotalRecords.Value;

    //        }
    //    }
    //    return invList;
    //}
}
