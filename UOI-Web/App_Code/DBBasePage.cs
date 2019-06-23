using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using UOI.Install;
using UOI.Log;

/// <summary>
/// Summary description for DBBasePage
/// </summary>
public partial class DBBasePage : Page
{
    protected string m_logFile = "install.log";
    protected string m_pathApp = string.Empty;
    protected string m_pathWebApp = string.Empty;
    protected System.Web.UI.WebControls.Label m_resultText;
    # region Messages
    protected virtual void ErrorMessage(string message)
    {
        Logger.Write("Error message", new Exception(message));
        this.m_resultText.Text = message;
        this.m_resultText.Visible = true;
        this.m_resultText.ForeColor = System.Drawing.Color.Red;
        this.Controls.Add(m_resultText);
    }

    protected virtual void InformationMessage(string message)
    {
        Logger.Write("Information message", message);
        this.m_resultText.Visible = true;
        this.m_resultText.Text = message;
        this.Controls.Add(m_resultText);
    }
    protected virtual string GetLogPath(string endPath)
    {
        return string.Format(@"{0}\{1}", m_pathApp + @"\App_Data", endPath);
    }
    protected static SqlServer getServer(string dbName, bool winNt, string userName, string userPassword, string serverName)
    {
        SqlServer server = new SqlServer(serverName);
        server.DbName = dbName;
        server.WindowsAuthentication = winNt;
        server.UserName = userName;
        server.UserPassword = userPassword;
        return server;
    }
    protected override void OnInit(EventArgs e)
    {
        m_pathWebApp = m_pathApp = this.Request.PhysicalApplicationPath;
        Logger.FilePath = GetLogPath(m_logFile);
        base.OnInit(e);
    }
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        m_resultText = new Label();
        this.m_resultText.ForeColor = System.Drawing.Color.Black;
        this.m_resultText.Visible = false;
    }
    protected ListItem[] getListItemCollection(string[] list)
    {
        ListItem[] lic = new ListItem[list.Length];
        for (int i = 0; i < list.Length; i++)
        {
            lic[i] = new ListItem(list[i], list[i]);
        }
        return lic;
    }
    # endregion
}
