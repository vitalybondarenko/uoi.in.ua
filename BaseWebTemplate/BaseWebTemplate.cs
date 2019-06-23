using System;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using UOI.Sys;
using System.Reflection;
using UOI.Log;

namespace UOI.WebUI
{
    public class BaseWebTemplate : System.Web.UI.Page
    {
        private string startXml = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>";
        
        public BaseWebTemplate()
        {
            this.LoadComplete += new System.EventHandler(this.PageInit);
        }
        
        protected void PageInit(object sender, EventArgs e)
        {
            Logger.Write("BaseWebTemplate", "PageInit", string.Format("request: {0}", Request.Url.ToString()));
            string requestPage = Request.Url.Segments[Request.Url.Segments.Length - 1];
            if (requestPage.ToLower() != "default.aspx") throw new Exception("No find page");
            NameValueCollection coll = Request.QueryString;
            string pageName = GetPageName(coll);
            Logger.Write("BaseWebTemplate", "PageInit", "Load page " + pageName);

            UOI.Sys.Page page = UOI.Sys.Page.GetObject(pageName);
            ContentCollection contents = page.GetPageData(coll);
            string webControlId;
            string xml;
            string xsl;

            foreach (UOI.Sys.Content content in contents)
            {
                webControlId = content.Control.WebContolId;
                xml = content.Xml;
                xsl = content.Xsl.XData;
                ApplyPageData(webControlId, xml, xsl);
            }

            Logger.Write("BaseWebTemplate", "PageInit", "Finish load page");
        }

        void ApplyPageData(string webControlId, string xml, string xsl)
        {
            xml = string.Format("{0}{1}", startXml, xml);
            xsl = string.Format("{0}{1}", startXml, xsl);
            Type type = this.GetType();
            FieldInfo field = type.GetField(webControlId, BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.IgnoreCase);
            if (field == null)
            {
                Logger.Write("BaseWebTemplate", "ApplyPageData", string.Format("Invalid webControlId: {0}", webControlId));
                throw new Exception(string.Format("Invalid webControlId: {0}", webControlId));
            }
            Xml control = (Xml)field.GetValue(this);

            try
            {
                System.Xml.XmlDocument docXsl = new System.Xml.XmlDocument();
                docXsl.LoadXml(xsl);
                System.Xml.Xsl.XslTransform trans = new System.Xml.Xsl.XslTransform();
                trans.Load(docXsl.CreateNavigator());

                System.Xml.XmlDocument docXml = new System.Xml.XmlDocument();
                docXml.LoadXml(xml);

                control.Document = docXml;
                control.Transform = trans;
            }
            catch (Exception ex)
            {
                Logger.Write("BaseWebTemplate", "ApplyPageData", "error apply data", ex);
                control.DocumentContent = null;
                control.Transform = null;
                throw ex;
            }
        }

        public static string GetPageName(NameValueCollection paramaters)
        {
            string result = null;
            if (paramaters.Count == 0) return StartPage;

            try
            {
                result = paramaters["page"].ToLower();
            }
            catch
            {
                result = null;
            }

            return result;
        }

        public static string StartPage
        {
            get
            {
                return System.Configuration.ConfigurationSettings.AppSettings["StartPage"];
            }
        }
    }
}
