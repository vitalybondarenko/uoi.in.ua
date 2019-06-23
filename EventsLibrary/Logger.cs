using System;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace UOI.Log
{
    public static class Logger
    {
        private static string m_logFilePath = string.Empty;
        private static string m_accumulator = string.Empty;

        static Logger()
        {
            m_logFilePath = @"uoi.csv";
        }

        public static string FilePath
        {
            get
            {
                return m_logFilePath;
            }
            set
            {
                m_logFilePath = value;
            }
        }

        private static void WriteLine(string line)
        {
            try
            {
                System.IO.File.AppendAllText(m_logFilePath, string.Format("{0}\r\n", line));
            }
            catch { //hide error
            }
            m_accumulator = m_accumulator + "\n" + line;
        }

        public static void Write(string message)
        {
            Write(null, null, message, null);
        }

        public static void Write(Exception exc)
        {
            Write(null, null, null, exc);
        }

        public static void Write(string source, string message)
        {
            Write(source, null, message, null);
        }

        public static void Write(string source, Exception exc)
        {
            Write(source, null, null, exc);
        }

        public static void Write(string source, string message, Exception exc) 
        {
            Write(source, null, message, exc);
        }

        public static void Write(string source, string operation, string message)
        {
            Write(source, operation, message, null);
        }

        public static void Write(string source, string operation, string message, Exception exc)
        {
            try
            {
                DateTime now = DateTime.Now;
                string dateTime = now.ToString("u");

                string excMessage = "";
                if (exc != null)
                {
                    excMessage = exc.Message;
                }

                WriteLine(string.Format("{0};{1};{2};{3};{4}", dateTime, source, operation, message, excMessage));
            }
            catch (Exception ex)
            {
            }
        }
        public static string Flush()
        {
            string t = m_accumulator;
            m_accumulator = string.Empty;
            return t;
        }
    }
}
