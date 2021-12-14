using MapTGDD.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MapTGDD.Controllers
{
	public class HomeController : Controller
	{
		Model_MapTGDDEntities DBMap = new Model_MapTGDDEntities();
		public ActionResult Index()
		{
			return View();
		}

		public JsonResult getAllTGDD()
		{

			var list = DBMap.DiaChi_TGDD.Select(item => new { MaDC = item.MaDC, name = item.TenDC, toado = item.ToaDo.AsText(), MaQH = item.MaQH, TenQH = item.QuanHuyen.TenQH });
			return Json(list, JsonRequestBehavior.AllowGet);
		}


	}
}