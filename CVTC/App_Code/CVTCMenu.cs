﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections.ObjectModel;
using System.Web.Script.Serialization;
using System.Data.Odbc;

/// <summary>
/// Summary description for CVTCMenu
/// </summary>
/// 
[Serializable]
public class CVTCMenu
{
    //string connectionString = @"Data Source=.\SQLEXPRESS; Initial Catalog=cvtc; User ID=cvtcuser; Password=cvtcuser";
    string connectionString;
	public CVTCMenu()
	{
		//
		// TODO: Add constructor logic here
		//
        connectionString = System.Web.Configuration.WebConfigurationManager.AppSettings["ConnectionString"].ToString();
    }

    #region Properties
    public int OID
    { get; set; }

    public string  NameMenu
    { get; set; }

    public int MenuID
    { get; set; }

    public string URL
    { get; set; }

    public int MenuLevel
    { get; set; }

    public int Parent
    { get; set; }

    public string IsLeave
    { get; set; }

    public string IsExpanded
    { get; set; }

    #endregion



    public Collection<CVTCMenu> GetAllMenu()
    {
        Collection<CVTCMenu> MenuList = new Collection<CVTCMenu>();
        //string connectionString = @"Data Source=.\SQLEXPRESS; Initial Catalog=cvtc; User ID=cvtcuser; Password=cvtcuser";
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {
                //command.Connection = connection;
                ////command.CommandText = "UPDATE dbo.Users SET " + "UserName='" + userName + "', " + " FirstName='" + firstName + "', " + " MiddleName='" + middleName + "'," + "LastName='" + lastName + "'," + "EmailID='" + emailID + "'" + " where UserID='" + userid + "' ";
                //command.CommandText = "INSERT INTO Users (UserName, FirstName, LastName, MiddleName, EmailID) VALUES (" + "'" + userName + "','" + firstName + "','" + lastName + "','" + middleName + "','" + emailID + "')";
                //connection.Open();
                //command.ExecuteNonQuery();

                command.Connection = connection;
                command.CommandText = "Menu_GetAllMenu";
                command.CommandType = CommandType.StoredProcedure;
                connection.Open();
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    CVTCMenu menu;
                    while (dataReader.Read())
                    {
                        menu = new CVTCMenu();
                        menu.OID = (int)dataReader["OID"];
                        menu.Parent = Convert.ToInt32(dataReader["Parent"]);
                        menu.NameMenu = Convert.ToString(dataReader["NameMenu"]);
                        menu.URL = Convert.ToString(dataReader["URL"]);
                        menu.MenuLevel = Convert.ToInt32(dataReader["MenuLevel"]);
                        menu.MenuID = Convert.ToInt32(dataReader["MenuID"]);
                        menu.IsLeave = Convert.ToInt32(dataReader["IsLeave"])==1?"true":"false";
                        menu.IsExpanded = Convert.ToInt32(dataReader["IsExpanded"])==1?"true":"false";
                        
                        MenuList.Add(menu);
                    }
                }

            }

            return MenuList;
        }
    }

    public Collection<CVTCMenu> GetAllParentMenu()
    {
        Collection<CVTCMenu> MenuList = new Collection<CVTCMenu>();

        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {
                //command.Connection = connection;
                ////command.CommandText = "UPDATE dbo.Users SET " + "UserName='" + userName + "', " + " FirstName='" + firstName + "', " + " MiddleName='" + middleName + "'," + "LastName='" + lastName + "'," + "EmailID='" + emailID + "'" + " where UserID='" + userid + "' ";
                //command.CommandText = "INSERT INTO Users (UserName, FirstName, LastName, MiddleName, EmailID) VALUES (" + "'" + userName + "','" + firstName + "','" + lastName + "','" + middleName + "','" + emailID + "')";
                //connection.Open();
                //command.ExecuteNonQuery();

                command.Connection = connection;
                command.CommandText = "{CALL Menu_GetAllParentMenu}";
                command.CommandType = CommandType.StoredProcedure;

                //OdbcParameter paramODI = new OdbcParameter("@parentid", OdbcType.VarChar, 50);
                //paramODI.Value = parentID;
                //command.Parameters.Add(paramODI);

                connection.Open();
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    CVTCMenu menu;
                    while (dataReader.Read())
                    {
                        menu = new CVTCMenu();
                        menu.OID = (int)dataReader["OID"];
                        menu.Parent = Convert.ToInt32(dataReader["Parent"]);
                        menu.NameMenu = Convert.ToString(dataReader["NameMenu"]);
                        menu.URL = Convert.ToString(dataReader["URL"]);
                        menu.MenuLevel = Convert.ToInt32(dataReader["MenuLevel"]);
                        menu.MenuID = Convert.ToInt32(dataReader["MenuID"]);
                        menu.IsLeave = Convert.ToInt32(dataReader["IsLeave"]) == 1 ? "true" : "false";
                        menu.IsExpanded = Convert.ToInt32(dataReader["IsExpanded"]) == 1 ? "true" : "false";

                        MenuList.Add(menu);
                    }
                }

            }

            return MenuList;
        }
    }

    public Collection<CVTCMenu> GetAllMenuByParentID(string parentID)
    {
        Collection<CVTCMenu> MenuList = new Collection<CVTCMenu>();
        
        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {
                //command.Connection = connection;
                ////command.CommandText = "UPDATE dbo.Users SET " + "UserName='" + userName + "', " + " FirstName='" + firstName + "', " + " MiddleName='" + middleName + "'," + "LastName='" + lastName + "'," + "EmailID='" + emailID + "'" + " where UserID='" + userid + "' ";
                //command.CommandText = "INSERT INTO Users (UserName, FirstName, LastName, MiddleName, EmailID) VALUES (" + "'" + userName + "','" + firstName + "','" + lastName + "','" + middleName + "','" + emailID + "')";
                //connection.Open();
                //command.ExecuteNonQuery();

                command.Connection = connection;
                command.CommandText = "{CALL Menu_GetAllMenuByParentID(?)}";
                command.CommandType = CommandType.StoredProcedure;

                OdbcParameter paramODI = new OdbcParameter("@parentid", OdbcType.VarChar,50);
                paramODI.Value = parentID;
                command.Parameters.Add(paramODI);

                connection.Open();
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    CVTCMenu menu;
                    while (dataReader.Read())
                    {
                        menu = new CVTCMenu();
                        menu.OID = (int)dataReader["OID"];
                        menu.Parent = Convert.ToInt32(dataReader["Parent"]);
                        menu.NameMenu = Convert.ToString(dataReader["NameMenu"]);
                        menu.URL = Convert.ToString(dataReader["URL"]);
                        menu.MenuLevel = Convert.ToInt32(dataReader["MenuLevel"]);
                        menu.MenuID = Convert.ToInt32(dataReader["MenuID"]);
                        menu.IsLeave = Convert.ToInt32(dataReader["IsLeave"]) == 1 ? "true" : "false";
                        menu.IsExpanded = Convert.ToInt32(dataReader["IsExpanded"]) == 1 ? "true" : "false";

                        MenuList.Add(menu);
                    }
                }

            }

            return MenuList;
        }
    }

    public CVTCMenu GetMenuByOID(int OID)
    {
        CVTCMenu menu=null;

        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {
                //command.Connection = connection;
                ////command.CommandText = "UPDATE dbo.Users SET " + "UserName='" + userName + "', " + " FirstName='" + firstName + "', " + " MiddleName='" + middleName + "'," + "LastName='" + lastName + "'," + "EmailID='" + emailID + "'" + " where UserID='" + userid + "' ";
                //command.CommandText = "INSERT INTO Users (UserName, FirstName, LastName, MiddleName, EmailID) VALUES (" + "'" + userName + "','" + firstName + "','" + lastName + "','" + middleName + "','" + emailID + "')";
                //connection.Open();
                //command.ExecuteNonQuery();

                command.Connection = connection;
                command.CommandText = "{CALL Menu_ByOID(?)}";
                command.CommandType = CommandType.StoredProcedure;

                OdbcParameter paramODI = new OdbcParameter("@MOID", OdbcType.Int);
                paramODI.Value = OID;
                command.Parameters.Add(paramODI);

                connection.Open();
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {
                    
                    if (dataReader.Read())
                    {
                        menu = new CVTCMenu();
                        menu.OID = (int)dataReader["OID"];
                        menu.Parent = Convert.ToInt32(dataReader["Parent"]);
                        menu.NameMenu = Convert.ToString(dataReader["NameMenu"]);
                        menu.URL = Convert.ToString(dataReader["URL"]);
                        menu.MenuLevel = Convert.ToInt32(dataReader["MenuLevel"]);
                        menu.MenuID = Convert.ToInt32(dataReader["MenuID"]);
                        menu.IsLeave = Convert.ToInt32(dataReader["IsLeave"]) == 1 ? "true" : "false";
                        menu.IsExpanded = Convert.ToInt32(dataReader["IsExpanded"]) == 1 ? "true" : "false";

                        
                    }
                }

            }

            return menu;
        }

    }

    public string BuildJQGridResults(Collection<CVTCMenu> menu, int numberOfRows, int pageIndex, int totalRecords)
    {

        JQGridResults result = new JQGridResults();
        List<JQGridRow> rows = new List<JQGridRow>();
        foreach (CVTCMenu m in menu)
        {
            JQGridRow row = new JQGridRow();
            row.id = m.OID;
            row.cell = new string[7];
            row.cell[0] = m.OID.ToString();
            row.cell[1] = m.NameMenu;
            row.cell[2] = m.MenuID.ToString();
            row.cell[3] = m.MenuLevel.ToString();
            row.cell[4] = m.Parent.ToString();
            row.cell[5] = m.IsLeave.ToString();
            row.cell[6] = m.IsExpanded.ToString();            

            rows.Add(row);
        }
        result.rows = rows.ToArray();
        result.page = pageIndex;
       result.total = totalRecords / numberOfRows;
       if (totalRecords % numberOfRows != 0) result.total += 1;
       result.records = totalRecords;
        return new JavaScriptSerializer().Serialize(result);
        //return new JavaScriptSerializer().Serialize(rows);
    }

    public int GetMaxMenuID()
    {
        int result = 0;
        try
        {
            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {
                    {
                        command.Connection = connection;
                        command.CommandText = "{CALL GetMaxMenuID}";
                        command.CommandType = CommandType.StoredProcedure;

                        connection.Open();

                        //int n = command.ExecuteNonQuery();
                        using (OdbcDataReader dataReader = command.ExecuteReader())
                        {
                            if (dataReader.Read())
                            {
                                result = Convert.ToInt32(dataReader["MenuID"]);
                            }
                        }

                        connection.Close();
                    }
                    
                }
            }

            
        }
        catch (Exception ex)
        {
            result = 0;
        }
        return result;
    }

    public bool SaveAssessmentMenuItem(CVTCMenu m)//(Collection<CVTCMenu> menuList)
    {
        bool result = false;
        try
        {
            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {
                    
                    //foreach (CVTCMenu m in menuList)
                    {
                        command.Connection = connection;
                        command.CommandText = "{CALL Menu_insert(?,?,?,?,?,?,?)}";
                        command.CommandType = CommandType.StoredProcedure;

                        OdbcParameter paramNameMenu = new OdbcParameter("@NameMenu", OdbcType.VarChar, 50);
                        paramNameMenu.Value = m.NameMenu;
                        command.Parameters.Add(paramNameMenu);

                        OdbcParameter paramMenuID = new OdbcParameter("@MenuID", OdbcType.Int);
                        paramMenuID.Value = m.MenuID;
                        command.Parameters.Add(paramMenuID);

                        OdbcParameter paramURL = new OdbcParameter("@URL", OdbcType.VarChar, 100);
                        paramURL.Value = m.URL;
                        command.Parameters.Add(paramURL);

                        OdbcParameter paramMenuLevel = new OdbcParameter("@MenuLevel", OdbcType.Int);
                        paramMenuLevel.Value = m.MenuLevel;
                        command.Parameters.Add(paramMenuLevel);

                        OdbcParameter paramParent = new OdbcParameter("@Parent", OdbcType.Int);
                        paramParent.Value = m.Parent;
                        command.Parameters.Add(paramParent);

                        OdbcParameter paramIsLeaf = new OdbcParameter("@IsLeaf", OdbcType.Int);
                        paramIsLeaf.Value = m.IsLeave=="true"?1:0;
                        command.Parameters.Add(paramIsLeaf);

                        OdbcParameter paramIsExpanded = new OdbcParameter("@IsExpanded", OdbcType.Int);
                        paramIsExpanded.Value = m.IsExpanded == "true" ? 1 : 0;
                        command.Parameters.Add(paramIsExpanded);

                        //command.Parameters.Add("@OID", OdbcType.Int);
                        //command.Parameters["@OID"].Direction = ParameterDirection.Output;
                        
                        connection.Open();
                        
                        int n = command.ExecuteNonQuery();

                        //string t_return = command.Parameters["@OID"].Value.ToString();

                        if (n == 1)
                            result = true;
                        else
                            result = false;
                        

                        connection.Close();
                    }
                    //Do some Coding here
                }
            }

            //result = true;
        }
        catch (Exception ex)
        {
            result = false;
        }
        return result;

    }

    public CVTCMenu GetMenuByMenuName(string Name)
    {
        CVTCMenu menu = null;

        using (OdbcConnection connection = new OdbcConnection(connectionString))
        {
            using (OdbcCommand command = new OdbcCommand())
            {
               

                command.Connection = connection;
                command.CommandText = "{CALL Menu_ByName(?)}";
                command.CommandType = CommandType.StoredProcedure;

                OdbcParameter paramODI = new OdbcParameter("@MenuName", OdbcType.VarChar ,200);
                paramODI.Value = Name;
                command.Parameters.Add(paramODI);

                connection.Open();
                using (OdbcDataReader dataReader = command.ExecuteReader())
                {

                    if (dataReader.Read())
                    {
                        menu = new CVTCMenu();
                        menu.OID = (int)dataReader["OID"];
                        menu.Parent = Convert.ToInt32(dataReader["Parent"]);
                        menu.NameMenu = Convert.ToString(dataReader["NameMenu"]);
                        menu.URL = Convert.ToString(dataReader["URL"]);
                        menu.MenuLevel = Convert.ToInt32(dataReader["MenuLevel"]);
                        menu.MenuID = Convert.ToInt32(dataReader["MenuID"]);
                        menu.IsLeave = Convert.ToInt32(dataReader["IsLeave"]) == 1 ? "true" : "false";
                        menu.IsExpanded = Convert.ToInt32(dataReader["IsExpanded"]) == 1 ? "true" : "false";


                    }
                }

            }

            return menu;
        }

    }

    public bool DeleteMenuByParent(int Parent)
    {
        bool result = false;
        try
        {
            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {

                   
                    {
                        command.Connection = connection;
                        command.CommandText = "{CALL Menu_DeleteByParent(?)}";
                        command.CommandType = CommandType.StoredProcedure;

                        

                        OdbcParameter paramMenuID = new OdbcParameter("@ParentID", OdbcType.Int);
                        paramMenuID.Value = Parent;
                        command.Parameters.Add(paramMenuID);

                        
                        connection.Open();

                        int n = command.ExecuteNonQuery();

                        if (n == 1)
                            result = true;
                        else
                            result = false;


                        connection.Close();
                    }
                    //Do some Coding here
                }
            }

           
        }
        catch (Exception ex)
        {
            result = false;
        }
        return result;

    }

    public bool DeleteMenuByMenuID(int MenuID)
    {
        bool result = false;
        try
        {
            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {


                    {
                        command.Connection = connection;
                        command.CommandText = "{CALL Menu_DeleteByID(?)}";
                        command.CommandType = CommandType.StoredProcedure;



                        OdbcParameter paramMenuID = new OdbcParameter("@MenuID", OdbcType.Int);
                        paramMenuID.Value = MenuID;
                        command.Parameters.Add(paramMenuID);


                        connection.Open();

                        int n = command.ExecuteNonQuery();

                        if (n == 1)
                            result = true;
                        else
                            result = false;


                        connection.Close();
                    }
                    //Do some Coding here
                }
            }


        }
        catch (Exception ex)
        {
            result = false;
        }
        return result;

    }

    public bool DeleteMenuByMenuURL(string  MenuURL)
    {
        bool result = false;
        try
        {
            using (OdbcConnection connection = new OdbcConnection(connectionString))
            {
                using (OdbcCommand command = new OdbcCommand())
                {


                    {
                        command.Connection = connection;
                        command.CommandText = "{CALL Menu_DeleteByURL(?)}";
                        command.CommandType = CommandType.StoredProcedure;



                        OdbcParameter paramMenuID = new OdbcParameter("@MenuURL", OdbcType.VarChar ,400);
                        paramMenuID.Value = MenuURL;
                        command.Parameters.Add(paramMenuID);


                        connection.Open();

                        int n = command.ExecuteNonQuery();

                        if (n == 1)
                            result = true;
                        else
                            result = false;


                        connection.Close();
                    }
                    //Do some Coding here
                }
            }


        }
        catch (Exception ex)
        {
            result = false;
        }
        return result;

    }

}
