
using MapTGDD.Models;
using System;
using System.Collections.Generic;
using System.Data.Spatial;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MapTGDD.Controllers
{
    public class MapTGDDController : Controller
    {
        // GET: MapTGDD
        Model_MapTGDDEntities DBMap = new Model_MapTGDDEntities();
        public ActionResult Index()
        {
            return View();
        }

        //++    Truy vấn lấy toàn bộ địa chỉ trên sql-----------------------------------------------------
        [System.Web.Services.WebMethod]
        [HttpGet]
        public JsonResult getAllTGDD()
        {

            var list = DBMap.DiaChi_TGDD.Select(item => new { MaDC = item.MaDC, name = item.TenDC, toado = item.ToaDo.AsText(), MaQH = item.MaQH, TenQH = item.QuanHuyen.TenQH });
            return Json(list, JsonRequestBehavior.AllowGet);
        }


		public JsonResult getQH()
		{
            var list = DBMap.QuanHuyens.Select(item => new { MaQH = item.MaQH, name = item.TenQH });
            return Json(list, JsonRequestBehavior.AllowGet);
        }

		public JsonResult Them(string name, string toado, string MaQH)
        {
            
            var diachi = new DiaChi_TGDD();
            diachi.TenDC = name;
            diachi.ToaDo = System.Data.Spatial.DbGeometry.FromText(toado);
            diachi.MaQH = MaQH;
            DBMap.DiaChi_TGDD.Add(diachi);
            DBMap.SaveChanges();         
            return Json("Lưu rồi nhe!", JsonRequestBehavior.AllowGet);
        }

        public JsonResult SuaToaDo(int MaDC, string toado)
        {

            var diachi = DBMap.DiaChi_TGDD.Find(MaDC);
            //diachi.TenDC = name;
            diachi.ToaDo = System.Data.Spatial.DbGeometry.FromText(toado);
            //diachi.MaQH = MaQH;
            //DBMap.DiaChi_TGDD.Add(diachi);
            DBMap.SaveChanges();
            return Json("Sửa tọa độ rồi nhe!", JsonRequestBehavior.AllowGet);
        }

        public JsonResult SuaTen(int MaDC, string name, string MaQH)
        {

            var diachi = DBMap.DiaChi_TGDD.Find(MaDC);
            diachi.TenDC = name;
            //diachi.ToaDo = System.Data.Spatial.DbGeometry.FromText(toado);
            diachi.MaQH = MaQH;
            //DBMap.DiaChi_TGDD.Add(diachi);
            DBMap.SaveChanges();
            return Json("Sửa tọa độ rồi nhe!", JsonRequestBehavior.AllowGet);
        }

        public JsonResult XoaDiem(int MaDC)
        {

            var diachi = DBMap.DiaChi_TGDD.Find(MaDC);
            DBMap.DiaChi_TGDD.Remove(diachi);
            DBMap.SaveChanges();
            return Json("Sửa tọa độ rồi nhe!", JsonRequestBehavior.AllowGet);
        }


    }
}