using MapTGDD.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MapTGDD.Controllers
{
    public class ThemBangJsonController : Controller
    {
        Model_MapTGDDEntities DBMap = new Model_MapTGDDEntities();
        // GET: ThemBangJson
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult save(string name, string toado, string MaQH)
        {

            var diachi = new DiaChi_TGDD();

            diachi.TenDC = name;
            diachi.ToaDo = System.Data.Spatial.DbGeometry.FromText(toado);
            diachi.MaQH = MaQH;
            DBMap.DiaChi_TGDD.Add(diachi);
            DBMap.SaveChanges();
            
            var list = DBMap.DiaChi_TGDD.Select(item => new { MaDC = item.MaDC, name = item.TenDC, toado = item.ToaDo.AsText(), MaQH = item.MaQH, TenQH = item.QuanHuyen.TenQH })
                .Where(item => item.MaDC == diachi.MaDC);
            //var list = DBMap.DiaChi_TGDD.

            return Json(list, JsonRequestBehavior.AllowGet);
        }

    }
}