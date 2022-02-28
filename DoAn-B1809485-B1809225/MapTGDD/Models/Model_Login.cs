using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MapTGDD.Models
{
	public class Model_Login
	{
		private Model_MapTGDDEntities db = new Model_MapTGDDEntities();
		public bool Login(string userName, string Password)
		{
			object[] sqlParas = {new SqlParameter("@UserName", userName), new SqlParameter("@Password", Password),};
			//Gọi thủ tục đã tạo có tên "Sp_Account_Login" sử dụng SingleOrDefault() để trả về giá trị duy nhất,
			var res = db.Database.SqlQuery<bool>("Sp_Account_Login @UserName, @Password", sqlParas).SingleOrDefault();
			return res;
		}

		[Required]
		public string Username { set; get; }
		public string Password { set; get; }
		public string Remenberme { set; get; }

	}
}